# Fix Old Typo

<img width="859" alt="image" src="https://github.com/Chalhotra/git-exercises-writeups/assets/135652026/b63fea21-cea6-4122-bdcf-0322f0b6148b">
<br> I actually got this question wrong for around 4 times before getting it right, and I realized that I had to go and fix the merge conflict first before moving ahead<br>

I first of all did ``` git log ``` to take a look at the addresses of all the past commits<br>
<img width="840" alt="image" src="https://github.com/Chalhotra/git-exercises-writeups/assets/135652026/ce5b3fc1-2802-4258-afeb-34d7105ba57b"><br>
Now, using the address of the *Ex: fix-old-typo* commit, my next command was ``` git rebase -i 98e6b86```, which takes us back to this commit, and then change ***pick*** to ***edit*** for the commit to be changed <br><img width="1051" alt="image" src="https://github.com/Chalhotra/git-exercises-writeups/assets/135652026/075e17ad-fdf4-44a3-a111-b2cd66ccb625"><br>

Now making the necessary changes in *file.txt*, we then add *file.txt* to the staging area ``` git add file.txt ```, and then doing a ``` git rebase --continue``` throws us a merge conflict because the next commit's *file.txt* conflicts with the current commit's *file.txt* <br> <br>  Fixing this by changing the *file.txt* in this commit as shown below: <br> <br> <img width="555" alt="image" src="https://github.com/Chalhotra/git-exercises-writeups/assets/135652026/95cc67be-33cf-423e-99a6-97aecfa64121"> **--->** <img width="443" alt="image" src="https://github.com/Chalhotra/git-exercises-writeups/assets/135652026/94af7654-98ab-4019-aa5e-deb1016808e2"><br> <br> Now doing ``` git rebase --continue``` after adding *file.txt* to the staging area, we get the challenge done



