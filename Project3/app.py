from flask import Flask, request, render_template, jsonify
import pymysql

db = pymysql.connect("localhost", "root", "<qwerty117>", "restaurant_data")

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    cursor = db.cursor()
    sql = "SELECT * FROM summary_table"
    cursor.execute(sql)
    results = cursor.fetchall()
    return jsonify(results)

if __name__ == '__main__':
    app.run(debug=True)