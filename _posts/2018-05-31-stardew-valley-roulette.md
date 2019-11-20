---
layout: post
title:  "Optimal Gambling at Stardew Valley's Roulette Wheel"
date:   2018-05-31 10:00:00 -0700
use_math: true
---

![The stardew valley wheel](/assets/stardew-wheel.png)

I've been playing a bit of Stardew Valley recently. At some point you go to the Stardew Valley Fair, where there's a roulette wheel you can play which comes up green with probability $3/4$ and orange with probability $1/4$. Winning gives you star tokens, and there's big incentive to get lots of stars: you can win a rare scarecrow! Betting on a roulette wheel biased in our favor seems like a great way to get them.

In this post, I'll show that the optimal strategy is to **bet half your stars on green in each round.**

The only thing standing between us and the rare scarecrow of our dreams is finding the optimal way to bet on this wheel. Obviously we don't want to bet all our stars on green, since there's some decent probability we'd lose everything. On the other hand, if we bet just one star each time, we would win an average of 1.5 stars for each star we bet, and if we played long enough we'd be sure to make money. But this is so slow! I'm a busy grad student! I can't spend all this time gambling, so instead, let's blow an afternoon proving what the optimal strategy is using martingales.

There are many options for defining an optimal strategy, but since it only takes 800 stars to win the rare scarecrow, we'll say the optimal strategy minimizes the expected time it takes to reach 800 stars. We'll prove that the optimal strategy is to bet half your stars each round.

More formally, let $X_n$ be the number of stars we have at round $n$, $\gamma$ the fraction of $X_n$ we bet, $\\{Y_n\\}_{n=0}^\infty$ be independent and identically distributed random variables where $Y_n = 1$ with probability $p$ and $Y_n = -1$ with probability $1-p$. Then, $$X_{n+1} = X_n + \gamma Y_n X_n = X_n(1+\gamma Y_n).$$

Let $T_a$ be the first round we have more than $a$ stars, or formally, $T_a = \inf\\{n : X_n \geq a\\}.$ We prove the following result, which happens to be a variation of the [Kelly Criterion](https://en.wikipedia.org/wiki/Kelly_criterion),

**Theorem.**  *In the above setting, $\E T_a$ is minimized if $\gamma = 2p-1.$*

*Proof.* Let $S_n = \log X_n = \sum_{i=1}^n \log(1+\gamma Y_i)$. Define $\beta = (p\log(1+\gamma) + (1-p)\log(1-\gamma))$, so that $Z_n = S_n - \beta n$. $Z_n$ is a martingale with respect to $F_n = \sigma(X_0, Y_1, \ldots, Y_n)$ since, $$
\begin{align*}
  \E[Z_n | F_{n-1}] &= S_{n-1} + \E[\log(1+\gamma Y_i)] - \beta(n-1) - \beta,\\
                    &= S_{n-1} + p\log(1+\gamma)+(1-p)\log(1-\gamma) - \beta(n-1) - \beta,\\
                    &= S_{n-1} - \beta(n-1).
\end{align*}
$$

Applying the Optional Stopping Theorem, since $\|(S_n - \beta n) - (S_{n-1} - \beta (n - 1))\| \leq \|\log(1+\gamma) - \beta\|$ which is a constant, $$
\begin{align*}
Z_0 &= \E[Z_{T_a}],\\
\log(X_0) &= \E[ S_{T_a} - \beta T_a],\\
    &= \log(a) - \beta \E T_a,\\
\E T_a &= \frac{\log(a) - \log(X_0)}{\beta}.
\end{align*}
$$

It remains to show that $\beta$ is maximized by $\gamma = 1/2$, but this follows since $$\frac{d}{d\gamma} \beta = \frac{1+\gamma-2p}{\gamma^2-1},$$
Setting $\frac{d}{d\gamma} \beta = 0$ yields $$\gamma = 2p-1.$$ $\square$
