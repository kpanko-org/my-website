---
title: Almost Found a Github Security Hole
date: 2025-05-31 21:46 -0400
categories: [software, github]
tags: [coding, git, github]
---
Recently, I was working through a [class on github][udemy] and almost
found a way to break the security protocols and write to a repo that
belongs to someone else.

In the course, the [instructor] shows people how to fork [his repository][his]
and then shows what it looks like when he deletes a file from it.

The thing is, I do not own that repo so I am not allowed to do that myself.
I wanted the full experience, so I planned to use [my own github][me] as
well as a [test account][testuser] that I created.
I forked [his repo][his] to [my account][mine], then my
[test account][testuser] forked it [again][downstream].
This way, I would have write access to both an upstream and
a downstream repository, just like the instructor did.

The instructor began the lecture by forking [his own repository][his] and
using `git clone` to create a workspace on his computer.
Then, he goes to [github.com][his] and removes a file from that project.

I do the same, but by [forking][mine] his repository,
then switching users and [forking again][downstream].
I also use `git clone` and have no issues doing that.

Next, I decide to add a new file to the repository, instead of deleting one.
Either way will create a new commit, so it does not make any difference.

I was able to write the new file (named [`upstream.txt`][upstreamtxt])
into my repository, as expected. See the screenshot below.

![github image 1](/assets/img/github1.png)
_My fork_

From this point, I click on the link `1 commit ahead` and
GitHub compares my repo with the instructor's repo.
See the next screenshot.

![github image 2](/assets/img/github2.png)
_Compare with upstream repo_

From this point, I click on the link `Create upstream.txt` to see the
commit information and I get a surprise! It seems that GitHub has allowed me
to write my file into the repository that I do not own!
I was even able to write a comment on that page, as well.

The URL it linked to showed that it is his repo:

[https://github.com/bstashchuk/JavaScript-Bible-ES6/commit/f3527880071d4c857fcb5c0c089264ae28a2eda8](https://github.com/bstashchuk/JavaScript-Bible-ES6/commit/f3527880071d4c857fcb5c0c089264ae28a2eda8)

![github image 3](/assets/img/github3.png)
_My commit got in his repo somehow?_

The reason this happened is that GitHub forks all share the same storage
on the backend. This lets them save storage space,
because when a repository is forked,
they do not have to duplicate all of the files.

The yellow warning message displayed hints at the reason:

> This commit does not belong to any branch on this repository,
> and may belong to a fork outside of the repository.
{: .prompt-warning}

As a consequence, I was able to create a commit object with hash `f3527880071d4c857fcb5c0c089264ae28a2eda8` and by adding it into my fork,
it went into the common storage area that all forks share.

If I manually edit the URL to have my own user ID, then all is well.

[https://github.com/kpanko/JavaScript-Bible-ES6/commit/f3527880071d4c857fcb5c0c089264ae28a2eda8](https://github.com/kpanko/JavaScript-Bible-ES6/commit/f3527880071d4c857fcb5c0c089264ae28a2eda8)

![github image 4](/assets/img/github4.png)
_My commit is actually in my repo where it belongs_

I verified that was not actually in the `bstashchuk` version by running this:

```bash
$ git ls-remote https://github.com/kpanko/JavaScript-Bible-ES6.git | grep f352788
f3527880071d4c857fcb5c0c089264ae28a2eda8        HEAD
f3527880071d4c857fcb5c0c089264ae28a2eda8        refs/heads/master
$ git ls-remote https://github.com/bstashchuk/JavaScript-Bible-ES6.git | grep f352788
```

The commit does not exist in that version; only in mine.

It was a quirk of the way that GitHub works, not a security flaw. Phew!

[udemy]: https://www.udemy.com/course/git-and-github-complete-guide
[instructor]: https://github.com/bstashchuk
[me]: https://github.com/kpanko
[testuser]: https://github.com/kpanko-testuser
[his]: https://github.com/bstashchuk/JavaScript-Bible-ES6
[mikes]: https://github.com/mikegithubber/JavaScript-Bible-ES6
[mine]: https://github.com/kpanko/JavaScript-Bible-ES6
[downstream]: https://github.com/kpanko-testuser/JavaScript-Bible-ES6
[upstreamtxt]: https://github.com/kpanko/JavaScript-Bible-ES6/blob/master/upstream.txt
