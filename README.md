# My implementation for CS231n

I finish this hw on my windows laptop rather than colab.

All expected goals were achieved correctly except for the following parts:

TODO:

- [X] transformer layer in [Transformer_Captioning.ipynb](assignments/assignment3/Transformer_Captioning.ipynb) . Due to unknown bug related to random initial layers.
  the reason is the wrong torch and numpy version which I use torch=2.8,numpy=2.2.
  degrade the torch and numpy to torch=1.12, numpy=1.26.
- [ ] SSL model train experiments in [Self_Supervised_Learning.ipynb.ipynb](assignments/assignment3/Self_Supervised_Learning.ipynb.ipynb) . Due to out of cpu memory
