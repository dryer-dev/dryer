function debounce (fn, timeout = 0) {
  let flag = false;
  return function() {
    if (!flag) {
      flag = true;
      setTimeout(_ => flag = false, timeout);
      fn.call(...arguments);
    }
  };
}

// generate a unique ref to ensure unique identifiers
function createRef() {
  // Save a timestamp
  const current_time = new Date().getTime();
  // generate a random integer
  const random_int = getRandomInt(0, 1000);
  // Return a string of the timestamp appended with the random integer
  return `${current_time}${random_int}`;
}
// returns a random integer between the specified values.
// source: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random
function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min) + min); // The maximum is exclusive and the minimum is inclusive
}

export {
  debounce,
  createRef
};
