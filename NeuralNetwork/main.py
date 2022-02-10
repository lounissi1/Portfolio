from NeuralNetwork import NeuralNetwork


if __name__ == "__main__":

    # the data
    X = [[0, 0, 1, 1],
         [0, 0, 1, 0],
         [1, 0, 0, 0],
         [0, 1, 1, 0],
         [0, 1, 0, 1],
         [1, 0, 1, 1],
         [0, 0, 1, 1],
         [1, 1, 0, 0],
         [1, 1, 1, 1],
         [0, 0, 0, 0],
         [1, 1, 1, 0]]

    Y = [1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1]

    # the weights
    w1 = [[.02, .05, .05, -.01],
          [-.02, -.01, .15, .1]]

    w2 = [-.05, .1]

    # init, train and evaluate the neural network
    nn = NeuralNetwork(w1, w2, 0.2)

    # train the neural network for 1000 iterations
    print("Training...")
    nn.train(X[3:6], Y[3:6], max_iter=1)

    print("\nTesting...")
    score = nn.test(X[:3], Y[:3])
    print(f"Test score: {score:.3f}")
