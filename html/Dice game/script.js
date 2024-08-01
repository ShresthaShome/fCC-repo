const listOfAllDice = document.getElementsByClassName("die");
const scoreInputs = document.getElementsByName("score-options");
const scoreSpans = document.querySelectorAll("#score-options  span");
const currentRound = document.getElementById("current-round");
const currentRoundRolls = document.getElementById("current-round-rolls");
const totalScore = document.getElementById("total-score");
const scoreHistory = document.getElementById("score-history");
const rollDiceBtn = document.getElementById("roll-dice-btn");
const keepScoreBtn = document.getElementById("keep-score-btn");
const rulesBtn = document.getElementById("rules-btn");
const rulesContainer = document.getElementsByClassName("rules-container")[0];

let isModalShowing = false;
let diceValuesArr = [];
let rolls = 0;
let score = 0;
let round = 1;

const rollDice = () => {
  diceValuesArr = [];
  Array.from(listOfAllDice).forEach((element, index) => {
    diceValuesArr.push(Math.floor(1 + Math.random() * 6));
    element.innerText = diceValuesArr[index];
  });
};

const updateStats = () => {
  currentRound.innerText = round;
  currentRoundRolls.innerText = rolls;
};

const updateRadioOption = (index, score) => {
  scoreInputs[index].disabled = false;
  scoreInputs[index].value = score;
  scoreSpans[index].innerText = `, score = ${score}`;
};

const getHighestDuplicates = (arr, count) => {
  if (count.some((x) => x >= 4))
    updateRadioOption(
      1,
      arr.reduce((sum, x) => (sum += x), 0)
    );
  if (count.some((x) => x >= 3))
    updateRadioOption(
      0,
      arr.reduce((sum, x) => (sum += x), 0)
    );
};

const detectFullHouse = (count) => {
  if (count.includes(3) && count.includes(2)) updateRadioOption(2, 25);
};

const checkForStraights = (count) => {
  const len = count.filter((x) => x > 0).length;
  if (len > 4) {
    if (!count.slice(2, 4).includes(0)) updateRadioOption(3, 30);
    if (!count.slice(1, 5).includes(0)) updateRadioOption(4, 40);
  } else if (len === 4) {
    for (let i = 0; i <= 2; i++) {
      if (!count.slice(i, i + 4).includes(0)) updateRadioOption(3, 30);
    }
  }
};

const updateScore = (selectedValue, achieved) => {
  score += parseInt(selectedValue);
  totalScore.textContent = score;
  scoreHistory.innerHTML += `<li>${achieved} : ${selectedValue}</li>`;
};

const resetRadioOptions = () => {
  scoreInputs.forEach((x) => {
    x.checked = false;
    x.disabled = true;
  });
  scoreSpans.forEach((x) => (x.innerText = ""));
};
const resetGame = () => {
  Array.from(listOfAllDice).forEach((element) => {
    element.innerText = 0;
  });
  rolls = 0;
  score = 0;
  round = 1;
  totalScore.innerText = 0;
  scoreHistory.innerText = "";
  currentRound.innerText = 1;
  currentRoundRolls.innerText = 0;
};

rulesBtn.addEventListener("click", () => {
  isModalShowing = !isModalShowing;
  rulesContainer.style.display = isModalShowing ? "block" : "none";
  rulesBtn.innerText = isModalShowing ? "Hide rules" : "Show rules";
});

rollDiceBtn.addEventListener("click", () => {
  if (rolls === 3) {
    alert("You have made three rolls this round. Please select a score.");
  } else {
    rolls++;
    resetRadioOptions();
    rollDice();
    updateStats();
    let count = Array(6).fill(0);
    diceValuesArr.forEach((x) => count[x - 1]++);
    getHighestDuplicates(diceValuesArr, count);
    detectFullHouse(count);
    checkForStraights(count);
    updateRadioOption(5, 0);
  }
});

keepScoreBtn.addEventListener("click", () => {
  const selected = Array.from(scoreInputs).find((x) => x.checked);
  if (selected) {
    rolls = 0;
    round++;
    updateStats();
    updateScore(selected.value, selected.id);
    if (round > 6) {
      const total = score;
      setTimeout(() => alert(`Game Over! Your total score is ${total}`), 500);
      resetGame();
    }
  } else alert("Please select an option or roll the dice");
  resetRadioOptions();
});
