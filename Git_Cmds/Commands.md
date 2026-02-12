## Git Commands

- To initialise git - `git init`
- This will be . file so hidden. Use `ls -a` to see the file
- Use "touch file_Name" to create file
- To see the status `git status`
- To track a file by git use `git add file_name`
- To track the changes use `git commit -m "Message that we need to pass"`
- To remove from staged `git restore --staged file_name`
- To remove file from Tracking `git rm --cache fileName`
- To delete file `rm -rf file_name`
- To delete some commits then copy the below hash of the commit upto which you want to delete and use `git reset hash_code`
- let say we want to need some files without creating history use `git stash`
- to get them back we use `git stash pop`

## GitHub

- To create a local repository `git remote add origin url`
- To push into repo use git push origin master
- To create a new branch `git branch newBranchName`
- To goTo some branch we use "`git checkout Branch_Name`"
- `git branch --list`
- To merge branch into main branch use "`git merge branch_name`"
- To clone a project `git clone project_git_url`
- To fetch all the commits from the other main branch we use
- `git fetch --all --prune` or `git pull upstream main`
- Let say you have 5 commits in sub branch and you want to merge them to main branch
- if you want to merge all the commits of sub as one commit into main we use
- `git rebase -i main_branch_commit_hash_code`
- And we can select which can be pick and which can be sqash
- Diff b/w fetch and pull: we can use pull to get code from github to local at the same time we can use fetch
  also but along with fetch we have to use merge command also
- To Undo the changes in working area use `git checkout file_Name` -- Dangerous Command
- To Undo the changes in staging area use `git reset file_Name` -- Dangerous Command

## Branching Strategies

- 1. Master 2. Dev 3. Feat 4.Bugfix/hotfix 5. Release

## Merging Strategies

- 1.  fastforward
- 2.  twoway/ recursive merge
