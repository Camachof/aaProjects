"use strict";

const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function Game() {
  this.stacks = [[3,2,1],[],[]];
}

Game.prototype.promptMove = function(moveTower) {
  let self = this;
  this.print();

  reader.question("What disk do you want to move? ", function(startTower){
    reader.question("Where do you want to move it? ", function(endTower){
      // console.log(`start: ${startTower} end: ${endTower}`);
      moveTower(startTower, endTower);
    });
  });

};

Game.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  let startTower = this.stacks[startTowerIdx];
  let endTower = this.stacks[endTowerIdx];

  if ((endTower.length === 0 && startTower.length > 0 ) ||
    startTower[startTower.length - 1] < endTower[endTower.length - 1]){
    return true;
  }
  return false;
};
Game.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    return true;
  }
  return false;
};

Game.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

Game.prototype.isWon = function () {
  if (this.stacks[1].length === 3 || this.stacks[2].length === 3) {
    return true;
  }
  return false;
};

Game.prototype.run = function (completionCallback) {
  let self = this;

  if (this.isWon()){
    completionCallback();
  }
  else {
    this.promptMove(function(start, end){
      self.move(start, end);
      self.run(completionCallback);
    });
  }
};

const game = new Game;
// console.log(game.stacks);
game.run(function() {
  reader.close();
  console.log("Congrats! You are good at stacks!");
});
