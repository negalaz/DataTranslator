import numpy as np
import pandas as pd
from make_data import make_data
from collections import Counter
 

def euclidean_distance(a, b):
    """Distancia euclideana entre dos arrays.

    Parametros
    ----------
    a: numpy array
    b: numpy array

    Returns
    -------
    distancia: float
    """



    return np.linalg.norm(a-b)


def cosine_distance(a, b):
    """Similitud coseno entre dos arrays.

    Parametros
    ----------
    a: numpy array
    b: numpy array

    Returns
    -------
    distancia: float
    """
    return (a@b)/(np.linalg.norm(a)*np.linalg.norm(b))


def manhattan_distance(a, b):
    """Distancia Manhattan entre dos arrays.

    Parametros
    ----------
    a: numpy array
    b: numpy array

    Returns
    -------
    distancia: float
    """
    return sum(abs(e1-e2) for e1, e2 in zip(a,b))


class KNNRegressor:
    """Regresor para KNN.

    Parametros
    ----------
    k: int, opcional (default = 5)
        Vecinos a incluir en la predicción.
    distancia: function, opcional (default = euclidean)
        Métrica de distancia a utilizar.
    """

    def __init__(self, k=5, distance=euclidean_distance):
        """Inicializar el objeto KNNRegressor."""
        self.k = k
        self.distance = distance

    def fit(self, X, y):
        """Ajustar el modelo con "X" como entrenamiento e "y" como objetivo.

        De acuerdo con el algoritmo KNN, los datos de entrenamiento son almacenados.

        Parametros
        ----------
        X: numpy array, shape = (n_observaciones, n_features)
            Conjunto de entrenamiento.
        y: numpy array, shape = (n_observaciones,)
            Valores objetivo.

        Returns
        -------
        self
        """
        self.x_train = np.array(X)
        self.y_train = np.array(y)
        
        return

    def predict(self, X):
        """Devuelve el valor predecido para la entrada X (conjunto de prueba).

        Asume que la forma de X es [n_observaciones de prueba, n_características] donde
        n_features es la misma que las n_features de los datos de
        de entrada.

        Parametros
        ----------
        X: numpy array, shape = (n_observaciones, n_features)
            Conjunto de prueba.

        Returns
        -------
        result: numpy array, shape = (n_observaciones,)
            Valores predecidos para cada dato de entrada.

        """
        results = []
        for x in X:
            vecinos_x = self.obtener_vecinos(x)
            valores_vecinos = pd.DataFrame(self.y_train[vecinos_x['idx']],columns=['target'])
           
            results.append(valores_vecinos['target'].mean())
        
        return results

    def obtener_vecinos(self,prueba):
        distancia_vecinos = [] 
        

        for idx,dato in enumerate(self.x_train):
          distancia_vecinos.append([idx,self.distance(prueba,dato)])
        
       
        df_distancia_vecinos = pd.DataFrame(distancia_vecinos,columns=['idx','distancia'])

        k_vecinos = df_distancia_vecinos.sort_values(by='distancia',ascending=True).head(self.k)

        return k_vecinos
    
