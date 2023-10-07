# Contributing Guidelines

> See [Code Reviews (internal, in Notion)](https://www.notion.so/mbta-downtown-crossing/Code-Reviews-df7d4d6bb6aa4831a81bc8cef1bebbb5) for a more detailed write up of PR and CR expectations.

## Writing PRs

A well written PR will make the code review process faster and easier and help you get more out of the review process. These are often useful things to consider including in a PR write up:

- A link to the corresponding Asana Task (or a note that there is no task).
- Any context around the PR or feature that’s beyond what’s in the Asana Task. What is the change and why is it needed?
- Screenshots. This makes it easy to see what the change is, and makes it possible to review visual changes without having to run the code.
- Any non-obvious hints the reviewer needs to understand and review the code easily. Explain why you chose a particular approach. If it's a big PR, give a quick explanation of the parts of your PR and how they fit together and communicate.
- Any open questions or parts of the code you're unsure about or particularly want a reviewer's opinion on.

In addition, having organized, well named commits can help a reviewer break a large PR down into bite-sized pieces when reviewing, so consider rebasing and organizing your work before opening the PR. You can use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) to provide more metadata for individual commits.

## Preparing your PR for Review

It is the author's responsibility to submit PRs that are easy to review in order not to waste reviewers' time and motivation:

- **Scope and size**: Changes should have a narrow, well-defined, self-contained scope that they cover exhaustively. For example, a change may implement a new feature or fix a bug. Shorter changes are preferred over longer ones. If a change is big, see if there’s a way to break it into multiple smaller PRs.
- Only submit **complete**, **self-reviewed** (by diff), and **self-tested** PRs. In order to save reviewers' time, test the submitted changes (i.e., run the test suite) and make sure they pass all builds as well as all tests and code quality checks, both locally and on the CI servers, before assigning reviewers.
- Refactoring CRs: **Pure Refactoring PRs should not alter behavior**; conversely, a behavior-changing CR should avoid excessive refactoring and code formatting changes. There are multiple good reasons for this:
  - Refactoring PRs often touch many lines and files and will consequently be reviewed with less attention. Unintended behavior changes can leak into the code base without anyone noticing.
  - Large refactoring PRs break cherry-picking, rebasing, and other source control magic. It is very onerous to undo a behavior change that was introduced as part of a repository-wide refactoring commit.
  - Expensive human review time should be spent on the program logic rather than style, syntax, or formatting debates. We prefer settling those with automated tooling like Checkstyle, TSLint, Baseline, Prettier, etc.
- However, some refactoring is often required when adding a new feature. Kent Beck’s maxim is useful: “for each desired change, make the change easy (warning: this may be hard), then make the easy change”. The two steps should be in separate commits, for easier review.

## When and How to Request a Review

Code reviews should happen after automated checks (tests, style, other CI) have completed successfully, but before the code merges to the repository's mainline branch. CRs should be prioritized as much as possible by reviewers as merges are blocked by the CR process.

Some things to note when looking for reviewers:

- You should directly assign a review to any member of your team. If they can’t do it, or if they expect to be delayed, they will let you know.
- If you are a team of 1 person, a list of potential reviewers will be provided to you.
- Always assign to a single reviewer. Make that person the *reviewer* and also *assignee*. They will make you the assignee when they are done providing their review.
- You only need approval from a single reviewer. If an additional person makes a comment or requests a change who is not the reviewer, you should read what they specify. However, as that person is not the reviewer, you are not bound to their requests nor do you require their approval to merge the PR.

## Responding to Code Review Comments

Part of the purpose of the code review is to improve the author's change request. Assume good faith on the part of your reviewer, and take their suggestions seriously even if you don't agree. Respond to every comment, even if it's only a simple "ACK" or "done" or “thumbs up” GitHub reaction emoji. Explain why you made certain decisions, why some function exists, etc. If you can't come to an agreement with the reviewer, switch to real-time communication or seek an outside opinion.

Fixes should be pushed to the same branch but in a separate commit. Squashing commits during the review process makes it hard for the reviewer to follow up on changes. Once the code review has been completed it may be appropriate to squash the “fix-up” commits only then.
