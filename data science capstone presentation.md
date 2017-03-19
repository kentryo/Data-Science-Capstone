Data science capstone presentation
========================================================
author: RH
date: 03/19/2017
autosize: true

This presentation aims at pitching the [shinyapp](https://kentryo.shinyapps.io/next_word_prediction/) for next-word prediction application.

This presentation is part of the work for the Coursera Data Science Capstone course.

Objectives
========================================================

The overall goal of this project is to build a shinyapp for predicting the next word and to make a product presentation to demonstrate the algorithm and and application instruction.

Specific goals are listed below:
- Analyze the [raw data](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)
- Analyze the [N-gram](https://en.wikipedia.org/wiki/N-gram) patterns and summarize
- Build a predictive model using [backoff](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=4&cad=rja&uact=8&ved=0ahUKEwjC5YPohOPSAhUk8YMKHVIIAzQQFggqMAM&url=http%3A%2F%2Fwww.cs.cornell.edu%2Fcourses%2Fcs4740%2F2012sp%2Flectures%2Fsmoothing%2Bbackoff-1-4pp.pdf&usg=AFQjCNEAmiD-dG4R6ZlLzfNY9CALJxXHVg&sig2=REhs3GGsol7DhGPaQnTD6w) algorithm
- Improve the application for prediction

Algorithm
========================================================

In general, this application used n-gram patterns and backoff algorithm for prediction.

[N-gram](https://en.wikipedia.org/wiki/N-gram) description is as: In the fields of computational linguistics and probability, an n-gram is a contiguous sequence of n items from a given sequence of text or speech. The items can be phonemes, syllables, letters, words or base pairs according to the application. The n-grams typically are collected from a text or speech corpus.

[Katz's back-off model](https://en.wikipedia.org/wiki/Katz's_back-off_model) is used for this application with some simplification. Katz back-off is a generative n-gram language model that estimates the conditional probability of a word given its history in the n-gram. It accomplishes this estimation by "backing-off" to models with smaller histories under certain conditions. By doing so, the model with the most reliable information about a given history is used to provide the better results.

![alt text](back.png)
Application instruction
========================================================

This application is aimed at predicting next-word using n-gram words analysis and simple backoff prediction methods.

Put a partial sentence or several words in the word-input and this application will predict the next-word based on the n-gram words analysis showing on the right side.

![alt text](app.png)

Summary and relative sources
========================================================

This project is for the work for the Coursera Data Science Capstone course.

The shinyapp is hosted at: https://kentryo.shinyapps.io/next_word_prediction/

The relative code could be found at: https://github.com/kentryo/data-science-capstone

The course info is at: https://www.coursera.org/learn/data-science-project/home/welcome
