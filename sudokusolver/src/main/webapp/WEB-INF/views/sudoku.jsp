<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sudoku Solver</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f8ff;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
            max-width: 600px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }
        table {
            border-collapse: collapse;
            margin: 0 auto;
        }
        table, td {
            border: 2px solid #000;
        }
        td {
            padding: 10px;
        }
        .form-control {
            text-align: center;
            font-weight: bold;
            font-size: 1.2em;
            border: none;
            background-color: #f9f9f9;
        }
        button {
            width: 100%;
            font-size: 1.2em;
            padding: 10px;
        }
        h1 {
            margin-bottom: 20px;
            font-size: 2em;
            color: #007bff;
        }
        h3 {
            margin-top: 20px;
            font-size: 1.5em;
        }
         input[type="number"] {
            font-size: 24px; /* Increase font size */
            font-weight: bold; /* Make the font bold */
            color: #495057; /* Darker gray color for text */
            text-align: center; /* Center align the text */
            background-color: #f1f1f1; /* Light gray background for input fields */
            border: 1px solid #343a40; /* Darker border for input fields */
        }
        input[type="number"]::-webkit-inner-spin-button, 
        input[type="number"]::-webkit-outer-spin-button { 
            -webkit-appearance: none; 
            margin: 0; 
        }
        input[type="number"] {
            -moz-appearance: textfield;
        }
        .btn-primary {
            margin-top: 20px;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">Sudoku Solver</h1>
        <form action="/solve" method="post">
            <table class="table table-bordered text-center">
                <%
                    int[][] board = (int[][]) request.getAttribute("board");
                    if (board == null) {
                        board = new int[9][9]; // Initialize a 9x9 grid if board is null
                    }
                    for (int row = 0; row < 9; row++) {
                        out.println("<tr>");
                        for (int col = 0; col < 9; col++) {
                            String value = board[row][col] == 0 ? "" : String.valueOf(board[row][col]);
                            out.println("<td>");
                            out.println("<input type='number' name='board[" + row + "][" + col + "]' value='" + value + "' class='form-control' min='1' max='9'>");
                            out.println("</td>");
                        }
                        out.println("</tr>");
                    }
                %>
            </table>
            <button type="submit" class="btn btn-primary">Solve</button>
        </form>
        <%
            Boolean solved = (Boolean) request.getAttribute("solved");
            if (solved != null) {
                if (solved) {
                    out.println("<h3 class='text-center'>Solved Successfully!</h3>");
                } else {
                    out.println("<h3 class='text-center'>Cannot solve the Sudoku.</h3>");
                }
            }
        %>
    </div>
</body>
</html>
