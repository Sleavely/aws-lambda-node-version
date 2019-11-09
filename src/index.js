
exports.handler = async () => {
  const versionWithoutV = process.version.split('v')[1]

  return {
    statusCode: 200,
    body: JSON.stringify(versionWithoutV)
  }
}
