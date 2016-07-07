RPMS_TO_INSTALL = libunwind-devel libtool

ROOTFS = build/rootfs

SRC_PREFIX = gperftools-2.5
SRC_TAR = ./$(SRC_PREFIX).tar.bz2

RPM_OUTPUT_DIR = $(ROOTFS)/output_rpms

all: $(ROOTFS)

submit:
	solvent submitproduct rpms $(RPM_OUTPUT_DIR)

approve:
	solvent approve --product=rpms

clean:
	sudo rm -rf build/rootfs* $(SRC_TAR)

$(ROOTFS):
	echo "Building gperftools"
	$(Q) sudo rm -fr $@
	$(Q) mkdir -p $@

	$(Q) sudo solvent bring --repositoryBasename=rootfs-clean-build --product=rootfs --destination=$@
	$(Q) mkdir -p $@/output_rpms
	$(Q) sudo strato/chroot.sh $(ROOTFS) yum install $(RPMS_TO_INSTALL) --assumeyes
	$(Q) sudo chroot $@ rm -fr /root/rpmbuild
	$(Q) sudo chroot $@ mkdir -p /root/rpmbuild/SOURCES
	$(Q) sudo chroot $@ mkdir -p /root/rpmbuild/SPECS
	$(Q) git archive --format=tar --prefix=$(SRC_PREFIX)/ HEAD | sudo sh -c "bzip2 -1c > $(SRC_TAR)"
	$(Q) sudo cp $(SRC_TAR) $@/root/rpmbuild/SOURCES
	$(Q) sudo cp strato/gperftools.spec $@/root/rpmbuild/SPECS/gperftools.spec
	$(Q) sudo chroot $@ chown root.root /root/rpmbuild/SPECS/gperftools.spec
	$(Q) sudo cp strato/gperftools-build.sh $@ 
	$(Q) sudo chroot $@ ./gperftools-build.sh
