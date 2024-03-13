# Save Your Work

In this challenge, we have to clear the current working area to make a bug fix and then restore the changes, to change the bug.txt file

We start with ``` git stash ``` which puts aside the current work, now I changed the bug.txt file, removing the bug, and committing the change

then by ``` git stash pop ```, got back the work, and changed bug.txt for a final time, and added it to the staging area, but on ``` git status``` we can see that ```program.txt``` is also unstaged, so adding program.txt, we can commit for the final time, and this solves the exercise
