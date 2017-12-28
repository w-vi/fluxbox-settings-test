REPO=wvi-fluxbox
BRANCH=unstable
ARCH=x86_64

build:
	buildpkg -b ${BRANCH} -a ${ARCH}  -p .
	mkdir -p ${REPO}/${ARCH}/
	cp -r /var/cache/manjaro-tools/pkg/${BRANCH}/${ARCH}/* ${REPO}/${ARCH}/
	repo-add ${REPO}/${ARCH}/${REPO}.db.tar.gz ${REPO}/${ARCH}/*.pkg.tar.*

commit:
	rm -f ${REPO}/${ARCH}/${REPO}.db && cp ${REPO}/${ARCH}/${REPO}.db.tar.gz ${REPO}/${ARCH}/${REPO}.db
	rm -f ${REPO}/${ARCH}/${REPO}.files && cp ${REPO}/${ARCH}/${REPO}.files.tar.gz ${REPO}/${ARCH}/${REPO}.files
	git add -f ./${REPO}
	git commit -m "update pkg repository"
	git push origin master

clean:
	rm -rf ${REPO}
	rm -rf fluxbox-settings
