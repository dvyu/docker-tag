#bash-3.2$ grep -i image: Pods/Sirius/Settings/deployment.yaml
#        image: docker.io/swisschains/settings-sirius:test
#bash-3.2$ grep -i image: Pods/Sirius/Settings/deployment.yaml | awk -F: '{printf("%s:%s:1.0.1",$1,$2)}'
#        image: docker.io/swisschains/settings-sirius:1.0.1bash-3.2$
#bash-3.2$
#bash-3.2$ grep -i image: Pods/Sirius/Settings/deployment.yaml | awk -F: '{printf("%s:%s:1.0.1\n",$1,$2)}'
#        image: docker.io/swisschains/settings-sirius:1.0.1
#bash-3.2$
#bash-3.2$ sed -E "s/image: .+$/Image: qqq/g" /tmp/qqqq
#bash-3.2$
#bash-3.2$ cp Pods/Sirius/Settings/deployment.yaml Pods/Sirius/Settings/deployment.yaml-orig
#bash-3.2$
#bash-3.2$ sed -e -i "s/image: .+$/image: docker.io/swisschains/settings-sirius:1.0.1/" Pods/Sirius/Settings/deployment.yaml
#bash-3.2$
#sed 's#^$# #g' file

YAML_FILE=Pods/Sirius/Settings/deployment.yaml
BUILD_NUMBER_PREFIX='1.0'
BUILD_NUMBER='23'
TAG="${BUILD_NUMBER_PREFIX}.${BUILD_NUMBER}"
echo TAG=${TAG}
DOCKER_IMAGE=$(grep image: ${YAML_FILE} | awk -F: '{printf("%s\n",$2)}' | awk '{print $1}')
DOCKER_IMAGE_SLASH=$(echo ${DOCKER_IMAGE} | sed 's#/#\\/#g')
echo DOCKER_IMAGE_SLASH=${DOCKER_IMAGE_SLASH}
#sed -E "s\#image: .+$\#image: ${DOCKER_IMAGE}\#" ${YAML_FILE} | grep image:
sed -E "s/image: .+$/image: ${DOCKER_IMAGE_SLASH}:${TAG}/" ${YAML_FILE} > ${YAML_FILE}.tmp
mv ${YAML_FILE}.tmp ${YAML_FILE}
