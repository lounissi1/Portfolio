from math import exp


class NeuralNetwork:

    # constructor
    def __init__(self, w1, w2, alpha=.2):

        self.w1 = w1
        self.w2 = w2
        self.alpha = alpha

    # private methods
    def _g(self, x):
        return 1 / (1 + exp(-x))

    def _forward(self, x, verbose=True):
        """ the forward pass of the training phase """

        # hidden layer
        self.l0 = x
        self.l1 = [self._g(sum(w*v for w, v in zip(W, x))) for W in self.w1]
        self.l2 = self._g(sum(w*v for w, v in zip(self.l1, self.w2)))

        if verbose:
            print("-" * 30)
            print("Froward:")
            print("input :", self.l0)
            print("layer :", [round(i, 2) for i in self.l1])
            print("output:", round(self.l2, 2))

        return self.l2
        # return 1 if self.l2 > .5 else 0  # use a binary output activation

    def _backward(self, y, y_pred, verbose=True):

        # delta of the output layer
        delta2 = (y - y_pred) * (1 - y_pred) * y_pred

        # delta of the hidden layer
        delta1 = [(1 - ak) * ak * self.w2[k] * delta2
                  for k, ak in enumerate(self.l1)]

        # update the weights of the output layer
        for i, w in enumerate(self.w2):
            self.w2[i] = w + self.alpha * self.l1[i] * delta2

        # update the weights of the hidden layer
        for j, W in enumerate(self.w1):
            for i, w in enumerate(W):
                self.w1[j][i] = w + self.alpha * self.l0[i] * delta1[j]

        if verbose:
            print("\nBackward:")
            print("w1:", [list(map(lambda x: round(x, 4), i)) for i in self.w1])
            print("w2:", [round(i, 3) for i in self.w2])

    # public methods
    def train(self, X, Y, max_iter=1000):
        """ train the neural network """

        for _ in range(max_iter):

            for x, y in zip(X, Y):
                y_pred = self._forward(x)
                self._backward(y, y_pred)

        print("=" * 30)

    def test(self, X, Y):
        """ Returns the squared error of the neural network
            smaller is better
        """

        err = 0

        for x, y in zip(X, Y):
            y_pred = self.predict(x)
            err += (y_pred - y) ** 2

        return err/len(Y)

    def predict(self, x):
        """ public wrapper around the _forward method """
        return self._forward(x)
