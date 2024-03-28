## Welcome

We invite you to join the Open Meeting team, which is made up of professional team folk alike!
There are many ways to contribute, including writing code, filing issues on GitHub, helping people
on our mailing lists, our chat channels, or on Stack Overflow, helping to triage, reproduce, or
fix bugs that people have filed, adding to our documentation,
doing outreach about OpenMeeting, or helping out in any other way.


We communicate primarily over GitHub and [Slack]().

Before you get started, we encourage you to read these documents which describe some of our community norms:
 
 1. [Our code of conduct](https://github.com/openimsdk/open-im-server/blob/main/CODE_OF_CONDUCT.md), which stipulates explicitly
   that everyone must be gracious, respectful, and professional. This
   also documents our conflict resolution policy and encourages people
   to ask questions.

 3. [Values](doc/Values.md), which talks about what we care most about.

## Pull Request Checklist

- Branch from the main branch and, if needed, rebase to the current main
  branch before submitting your pull request. If it doesn't merge cleanly with
  main you may be asked to rebase your changes.

- Commits should be as small as possible, while ensuring that each commit is
  correct independently (i.e., each commit should compile and pass tests).

- Commits should be accompanied by a Developer Certificate of Origin
  (http://developercertificate.org) sign-off, which indicates that you (and
  your employer if applicable) agree to be bound by the terms of the
  [project license](../LICENCE). In git, this is the `-s` option to `git commit`

- If your patch is not getting reviewed or you need a specific person to review
  it, you can @-reply a reviewer asking for a review in the pull request or a
  comment, or you can ask for a review via [email](mailto:info@openim.io).

- Add tests relevant to the fixed bug or new feature.

For specific git instructions, see [GitHub workflow 101](doc/GithubWorkflow.md).

### Code review processes and automation

PRs will automatically be assigned to
[code owners](https://github.com/openimsdk/open-im-server/blob/main/docs/CODEOWNERS)
for review.
If a code owner is creating a PR, they should explicitly pick another OpenMeeting team member as a code reviewer.

### Style

App project follow Flutter style for Dart—for the languages they
use, and use auto-formatters:
- [Dart](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo) formatted
  with `dart format`
- [Java](https://google.github.io/styleguide/javaguide.html) formatted with
  `google-java-format`
- [Kotlin](https://developer.android.com/kotlin/style-guide) formatted with
  `ktfmt`
- [Objective-C](https://google.github.io/styleguide/objcguide.html) formatted with
  `clang-format`
- [Swift](https://google.github.io/swift/) formatted with `swift-format`

### Releasing

If you are a team member landing a PR, or just want to know what the release
process is for package changes, see [the release
documentation]().
