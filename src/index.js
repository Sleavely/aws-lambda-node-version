
exports.handler = async () => {
  const versionWithoutV = process.version.split('v')[1]
  return versionWithoutV
}
