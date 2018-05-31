---
layout: post
title:  "Two Python Libraries"
date:   2017-05-23 10:00:00 -0400
---

I've been doing a lot of research work in python, and find myself writing the same code over and over again. To help with this, I've written a few libraries for some of the common things that I do.

<!--more-->

#### [num_solver](https://github.com/brucespang/num_solver)

Back in 1998, there was a really nice paper from [Kelly et al](http://www.statslab.cam.ac.uk/~frank/rate.pdf) on modelling TCP using mathemtical optimization. There's a set of fairly common steps you need to do to use these models: you have to turn a graph into a routing matrix, write out the optimization problem, remember which utility functions you're using, and deal with all the finicky bits of the scipy optimizer. I've written a library, `num_solver`, which does all this automatically. If you're interested in the behavior of how, say, two TCP Vegas flows with different RTTs would share a single 10 Mbps link, you could do the following:

```python
import num_solver

R = [[1,1]]
c = [10]
print num_solver.solve(num_solver.vegas([40, 60]), R, c)
# [4., 6.]
```


#### [plorts](https://github.com/brucespang/plorts)

I make a ton of graphs while doing research. I use matplotlib, and the matplotlib api is impossible to remember. I probably spend 90% of my time googling some variation of "how to make stackplot work" or "no seriously it's just a stackplot." Plorts is a library I'm working on which remembers all this stuff for me.

It includes some default styles which I like more than the matplotlib defaults. It also has some common graphing functions that I do, including line plots from a dataframe, stackplots with different x-values (good for timeseries), and more.

They all use the following initialization code:

```python
import plorts
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

plt.style.use(['plorts', 'plorts-web'])

xmax = 2*np.pi
f = lambda x,offset: (offset+1)*np.sin(x-offset)
xs = np.arange(0,xmax,0.1)
offsets = [4,5,6,7]
df = pd.DataFrame([[x, f(x, offset), i, np.abs(f(x, offset))] for x in xs for i,offset in enumerate(offsets)], columns=["x", "y", "offset", "abs"])
```

![line plot](/img/plorts_output/line-plot.png)
```python
plt.figure()
plt.title("Line Plot Example")
plorts.plot(df, x="x", y="y", hue="offset")
plorts.legend(loc='end')
plt.ylabel("Y label")
plt.xlabel("X label")
plorts.style_axis()
```

![scatter plot](/img/plorts_output/scatter-plot.png)
```python
plt.figure()
plt.title("Scatter Plot Example")
plorts.scatter(df, x="x", y="y", hue="offset")
plorts.legend(loc='end')
plt.ylabel("Y label")
plt.xlabel("X label")
plorts.style_axis()
```
![stack plot](/img/plorts_output/stack-plot.png)
```python
plorts.stackplot(df, x="x", y="abs", hue="offset")
plt.legend(loc='best')
plt.ylabel("$|\\sin(x)|$")
plt.title("Stacked Plot Example")
plorts.style_axis()
```

![box plot](/img/plorts_output/boxplot.png)
```python
plt.figure()
sns.boxplot(data=df, x="offset", y="y")
plt.ylabel("Y label")
plt.xlabel("X label")
plt.title("Boxplot Example")
plorts.style_axis()
```

![histogram](/img/plorts_output/histogram.png)
```python
plt.figure()
plt.hist(df.y, rwidth=0.98, color='C4')
plt.ylabel("Y label")
plt.xlabel("X label")
plt.title("Histogram Example")
plorts.style_axis()
```
