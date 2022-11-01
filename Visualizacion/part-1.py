import dash
from dash import html

app = dash.Dash(__name__)

app.layout = html.Div(children=[
    html.Img(
        src='assets\\bike.jpg',
        style={'width': '20%', 'border': '1px solid #FF6B00'},
        alt='image'),

    html.H1(children='Nelther Galaz Perez', style={'color': '#002D6F'}),
    html.P('Software engineer at DeAcero', style={'width':'20%','color': 'black'})
])

if __name__ == '__main__':
    app.run_server(debug=True)