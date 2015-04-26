module.exports = {
  concurrency: Math.max((require('os').cpus().length || 1) * 2, 2)
};
