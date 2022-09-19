package org.datavaultplatform.worker.operations;

import org.datavaultplatform.common.event.EventSender;
import org.datavaultplatform.common.event.deposit.CompleteCopyUpload;
import org.datavaultplatform.common.event.deposit.StartCopyUpload;
import org.datavaultplatform.common.io.Progress;
import org.datavaultplatform.common.storage.ArchiveStore;
import org.datavaultplatform.common.storage.Device;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.HashMap;
import java.util.concurrent.Callable;

public class DeviceTracker implements Callable {

    private String jobID;
    private String depositId;
    private File tarFile;
    private EventSender eventSender;
    private int chunkNumber = 0;
    private String archiveStoreId;
    private ArchiveStore archiveStore;
    private String userID;
    private static final Logger logger = LoggerFactory.getLogger(DeviceTracker.class);

    @Override
    public HashMap<String, String> call() throws Exception {
        HashMap<String, String> archiveIds = new HashMap<>();
        // Progress tracking (threaded)
        Progress progress = new Progress();
        ProgressTracker tracker = new ProgressTracker(progress, this.jobID, this.depositId, this.tarFile.length(), this.eventSender);
        Thread trackerThread = new Thread(tracker);
        trackerThread.start();
        String depId = this.depositId;
        if (this.chunkNumber > 0) {
            depId = depId + "." + this.chunkNumber;
        }
        String archiveId;
        // kick off new thread for each device ( we may already have kicked off x threads for chunks)
        try {
            this.eventSender.send(new StartCopyUpload(this.jobID, this.depositId, ((Device) this.archiveStore).name, this.chunkNumber).withUserId(this.userID));
            if (((Device)this.archiveStore).hasDepositIdStorageKey()) {
                archiveId = ((Device) this.archiveStore).store(depId, this.tarFile, progress);
            } else {
                archiveId = ((Device) this.archiveStore).store("/", this.tarFile, progress);
            }
            this.eventSender.send(new CompleteCopyUpload(this.jobID, this.depositId, ((Device) this.archiveStore).name, this.chunkNumber).withUserId(this.userID));
        } finally {
            // Stop the tracking thread
            tracker.stop();
            trackerThread.join();
        }

        logger.info("Copied: " + progress.dirCount + " directories, " + progress.fileCount + " files, " + progress.byteCount + " bytes");
        // wait for all 3 to finish

        if (this.chunkNumber > 0 && archiveIds.get(this.archiveStoreId) == null) {
            logger.info("ArchiveId is: " + archiveId);
            String separator = FileSplitter.CHUNK_SEPARATOR;
            logger.info("Separator is: " + separator);
            int beginIndex = archiveId.lastIndexOf(separator);
            logger.info("BeginIndex is: " + beginIndex);
            archiveId = archiveId.substring(0, beginIndex);
            logger.debug("Add to archiveIds: key: "+this.archiveStoreId+" ,value:"+archiveId);
            archiveIds.put(archiveStoreId, archiveId);
            logger.debug("archiveIds: "+archiveIds);
        } else if(this.chunkNumber == 0) {
            archiveIds.put(archiveStoreId, archiveId);
        }
        logger.debug("Device thread completed: " + archiveId);
        return archiveIds;
    }

    public String getJobID() {
        return this.jobID;
    }

    public void setJobID(String jobID) {
        this.jobID = jobID;
    }

    public String getDepositId() {
        return this.depositId;
    }

    public void setDepositId(String depositId) {
        this.depositId = depositId;
    }

    public File getTarFile() {
        return this.tarFile;
    }

    public void setTarFile(File tarFile) {
        this.tarFile = tarFile;
    }

    public EventSender getEventSender() {
        return this.eventSender;
    }

    public void setEventSender(EventSender eventSender) {
        this.eventSender = eventSender;
    }

    public int getChunkNumber() {
        return this.chunkNumber;
    }

    public void setChunkNumber(int chunkNumber) {
        this.chunkNumber = chunkNumber;
    }

    public String getArchiveStoreId() {
        return this.archiveStoreId;
    }

    public void setArchiveStoreId(String archiveStoreId) {
        this.archiveStoreId = archiveStoreId;
    }

    public ArchiveStore getArchiveStore() {
        return this.archiveStore;
    }

    public void setArchiveStore(ArchiveStore archiveStore) {
        this.archiveStore = archiveStore;
    }

    public String getUserID() {
        return this.userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }
}
