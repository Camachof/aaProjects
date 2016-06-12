"use strict";

function Board () {
  this.grid = new Array(3);
  for (let i = 0; i < this.grid.length; i++) {
    this.grid[i] = ["_","_","_"];
  }
}

Board.prototype.diagonals = function () {
  const diags = [
    [0,0], [1,1], [2,2],
    [2,0], [1,1], [0,2]
  ];
  return diags.map(pos => {
    return this.grid[pos[0]][pos[1]];
  });
};

// Array.prototype.transpose = function(){
//   const transposedArr = [];
//   const that = [].concat.apply([],this);
//
//   for (var n = 0; n < this.length; n++) {
//     let row = [];
//
//     for (var i = 0; i < that.length; i++) {
//       if(i % this.length === n){
//         row.push(that[i]);
//       }
//     }
//     transposedArr.push(row);
//   }
//   return transposedArr;
// };


Board.prototype.won = function () {
  const leftDiag = this.diagonals().slice(0,3);
  const rightDiag = this.diagonals().slice(3);

  let winner = leftDiag.every( mark => {
    mark === this[0] && this[0] !== "_" ;
  });

  console.log(winner);
};

const board = new Board;
board.won();




//
// Board.prototype.winner = function () {
//
// };
//
// Board.prototype.empty = function (pos) {
//   this.grid[pos[0]][pos[1]] === "_";
// };
//
// Board.prototype.placeMark = function (pos, mark) {
//   this.grid[pos[0]][pos[1]] = mark;
// };
