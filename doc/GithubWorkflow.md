## Github workflow

You will need to fork the servo/servo repository in order to be able to publish your changes. In these instructions <openmeeting> is the name of the remote pointing to the remote xxx@github.com:openmeeting/openmeeting.git and <fork> is the remote pointing at your fork of the repository.

1. Fetch the latest code and create a local branch:

```$ git fetch <openmeeting>```

```$ git checkout -b <local_branch> <openmeeting>/main```

2. Code/hack/do stuff then commit:

```$ git commit -a ```

See Git tips below for helpful tips on using git.

3. Push local branch to your cloned repository:
```
$ git push --set-upstream <fork> <local_branch> 
```
(```git push -u <fork> <local_branch>[:remote_name]``` should work if you want to publish your changes to a branch with a different name than ```[local_branch]```.)

4. Create a [PR in GitHub](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests). If you know who should code review this PR, you can write ```r? @username``` in the text of the PR and they will automatically be assigned to it. If not, don't worry: a reviewer will be randomly selected and notified.

5. Wait for reviewers' feedback - if something needs to be fixed, either amend the existing commits if the changes are minor, or fix it in a new commit on the same branch, optionally using ```--fixup```:

```$ git commit --fixup=<sha1_of_relevant_commit_on_branch>```

Alternatively, add the following to your .gitconfig and simply use git fixup:
```
[alias]
	fixup = !sh -c 'git commit -m \"fixup! $(git log -1 --format='\\''%s'\\'' $@ | sed \"s/fixup\\! //\")\"' -
	ri = rebase --interactive --autosquash
```
6. Use ```git push``` to update the Pull Request. Repeat steps 5-6 until the review is accepted. If existing commits were amended, a force push will be necessary (see step 8).

7. When you know there is a substantive change on main that affects your patch, update <openmeeting> and rebase your local branch to make sure your patch still applies correctly:
```
$ git fetch <openmeeting>

$ git rebase <openmeeting>/main
```
You may have to fix merge conflicts on the way.

8. Force-push your changes:
```
$ git push -f <fork> <local_branch>
```
9. Once your patch is accepted and based on a recent main, squash the commits together for a cleaner history (if requested):
```
$ git rebase -i --autosquash <openmeeting>/main
```
10. Force push the squashed commits to github (see step 8).

11. When the reviewer thinks the code is ready, our Homu bot will automatically test and merge your PR. Congratulations!
