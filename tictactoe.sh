#!/bin/bash
# This application produces a Tic Tac Toe game to be played between 2 players
# Future Version will include a Computer Player

# --------- GLOBAL VARIABLES
declare -a squares
squares=(" " " " " " " " " " " " " " " " " ")
rounds=0
playerTurn=1
goodInput=0
gameWinner=0
winningSquare1=-1
winningSquare2=-1
winningSquare3=-1


# ---------- COLORS
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'


# --------- FUNCTIONS
# Prints the board using the array squares
function printBoard()
{
	clear
	echo
	echo "  ${squares[0]} | ${squares[1]} | ${squares[2]} "
	echo -e " -----------"
	echo "  ${squares[3]} | ${squares[4]} | ${squares[5]} "
	echo -e " -----------"
	echo "  ${squares[6]} | ${squares[7]} | ${squares[8]} "
	echo
}

function checkForWinner()
{
	gameWinner=0
	
	# Checks rows
	checkLocation 0 1 2
	checkLocation 3 4 5
	checkLocation 6 7 8	
	
	# Checks Diagonals
	checkLocation 0 4 8
	checkLocation 6 4 2	
	
	# Checks Columns
	checkLocation 0 3 6
	checkLocation 1 4 7
	checkLocation 2 5 8	

}

function checkLocation()
{
	# Parameters will be square1 square2 square3
	# Function will check if they are all 'x' or all 'o'
	if [[ ${squares[$1]} == ${squares[$2]}  && ${squares[$2]} == ${squares[$3]} && ${squares[$1]} == "x" ]]
	then
		gameWinner=1
		winningSquare1=$1
		winningSquare2=$2
		winningSquare3=$3
	fi
	
	if [[ ${squares[$1]} == ${squares[$2]}  && ${squares[$2]} == ${squares[$3]} && ${squares[$1]} == "o" ]]
	then
		gameWinner=1
		winningSquare1=$1
		winningSquare2=$2
		winningSquare3=$3		
	fi

}

function adjustPlay()
{
	# Adjust number chosen from numeric keyboard to indexes in the array 
	case $play in
		1) play=6 ;;
		2) play=7 ;;
		3) play=8 ;;
		4) play=3 ;;
		5) play=4 ;;
		6) play=5 ;;
		7) play=0 ;;
		8) play=1 ;;	
		9) play=2 ;;
		
		*) play=-1 ;;
	esac
}

# Prints the board with the winning squares marked green
function printBoardWinner() 
{
	clear
	printf "\n  "
	
	if [[ $winningSquare1 -eq 0 || $winningSquare2 -eq 0 || $winningSquare3 -eq 0 ]]
	then
		printf "${GREEN}${squares[0]}${NC}"
	else
		printf "${squares[0]}"
	fi
	
	printf " | "
	
	if [[ $winningSquare1 -eq 1 || $winningSquare2 -eq 1 || $winningSquare3 -eq 1 ]]
	then
		printf "${GREEN}${squares[1]}${NC}"
	else
		printf "${squares[1]}"
	fi
	
	printf " | "
	
	if [[ $winningSquare1 -eq 2 || $winningSquare2 -eq 2 || $winningSquare3 -eq 2 ]]
	then
		printf "${GREEN}${squares[2]}${NC}"
	else
		printf "${squares[2]}"
	fi
	
	printf " \n"
	echo -e " -----------"
	
	printf "  "
	
	if [[ $winningSquare1 -eq 3 || $winningSquare2 -eq 3 || $winningSquare3 -eq 3 ]]
	then
		printf "${GREEN}${squares[3]}${NC}"
	else
		printf "${squares[3]}"
	fi
	
	printf " | "
	
	if [[ $winningSquare1 -eq 4 || $winningSquare2 -eq 4 || $winningSquare3 -eq 4 ]]
	then
		printf "${GREEN}${squares[4]}${NC}"
	else
		printf "${squares[4]}"
	fi
	
	printf " | "
	
	if [[ $winningSquare1 -eq 5 || $winningSquare2 -eq 5 || $winningSquare3 -eq 5 ]]
	then
		printf "${GREEN}${squares[5]}${NC}"
	else
		printf "${squares[5]}"
	fi
	
	printf " \n"
	echo -e " -----------"
	
	printf "  "
	
	if [[ $winningSquare1 -eq 6 || $winningSquare2 -eq 6 || $winningSquare3 -eq 6 ]]
	then
		printf "${GREEN}${squares[6]}${NC}"
	else
		printf "${squares[6]}"
	fi
	
	printf " | "
	
	if [[ $winningSquare1 -eq 7 || $winningSquare2 -eq 7 || $winningSquare3 -eq 7 ]]
	then
		printf "${GREEN}${squares[7]}${NC}"
	else
		printf "${squares[7]}"
	fi
	
	printf " | "
	
	if [[ $winningSquare1 -eq 8 || $winningSquare2 -eq 8 || $winningSquare3 -eq 8 ]]
	then
		printf "${GREEN}${squares[8]}${NC}"
	else
		printf "${squares[8]}"
	fi

	printf "\n\n"
}

function playOneGame() 
{
while : 
do
	# Prints the updated board
	printBoard

	# Marks end of game for ties
	if [[ rounds -eq 9 ]]
	then
		break
	fi

	# reads the square the player wants to play
	read -p "Player #$playerTurn's turn: " -n 1  play
	adjustPlay
	
	# If user inputs anything other than a single digit from 1-9, asks again
	# Prevents letters, 0 and symbols
	# If square already taken, asks again	
	goodInput=0
	until [[ $goodInput -eq 1 ]]
	do
		clear
		printBoard
		if [[ $play -lt 0 || $play -gt 8 ]]
		then
			read -p "Only numbers between 1-9 please :D :" -n 1  play
			adjustPlay			
		elif [[ ${squares[$play]} != " " ]]
		then
			read -p "Square already taken, choose another :" -n 1  play
			adjustPlay
		else
			goodInput=1
		fi
	done
		
	# Adds the symbol to the square and switches player  
	if [[ $playerTurn -eq 1 ]] 
	then
		squares[$play]="x"
	else
		squares[$play]="o"
	fi	

	# If there is a winner, end the game and print info
	checkForWinner
	if [[ $gameWinner -eq 1 ]]
	then
		break
	fi
	
	# Upgrades rounds and player number
	((rounds++))
	((playerTurn = 3 - $playerTurn)) # Will flip between 2 and 1
	
	checkForWinner
done


# Post-game info, prints the board and dislpays the winner, if there is one

if [[ $gameWinner -eq 1 ]]
then
	printBoardWinner
	echo "Player #$playerTurn is the WINNER! CONGRATULATIONS! :D"
else
	printBoard
	echo "It's a tie! Good game :)"
fi

}

# Resets the parameters of the game
function resetGame()
{
	squares=(" " " " " " " " " " " " " " " " " ")
	rounds=0
	playerTurn=1
	goodInput=0
	gameWinner=0
	winningSquare1=-1
	winningSquare2=-1
	winningSquare3=-1
}




# ---------- ENTRY POINT
clear

# Application loop, will exit when user selects 'n'
while :
do
	# Resets the game parameters
	resetGame
	
	# Plays one game of Tic Tac Toe and displays the results
	playOneGame
	sleep 2
	
	# Asks if user wants to play another game
	printf "\nDo you want to play again?\n[Y]es - [N]o\n"
	
	# Keeps asking for a one-key-input until it is 'y' or 'n'
	key=""
	while [[ $key != "y" && $key != "n" ]]
	do
		read -s -n 1 key
	done
	
	# If 'y', replay; if 'n', exit the loop
	case $key in
		"y") continue ;;
		"n") break ;;
	esac
done

# Clears the screen and exits
clear



















