function Clock () {
  // 1. Create a Date object.
  // 2. Store the hours, minutes, and seconds.
  // 3. Call printTime.
  // 4. Schedule the tick at 1 second intervals.

  this.date = new Date();
}

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  // Use console.log to print it.
  console.log(`${this.date.getHours()}:${this.date.getMinutes()}:${this.date.getSeconds()}`);
};

Clock.prototype._tick = function () {
  // 1. Increment the time by one second.
  // 2. Call printTime.
  this.date.setTime(this.date.valueOf() + 1000);
  this.printTime();
};

const clock = new Clock();
clock.printTime();
clock._tick();
setInterval(function() {
  clock._tick();
}, 1000)
