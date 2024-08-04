package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class SudokuController {

    @RequestMapping("/")
    public String showSudokuForm(Model model) {
        int[][] board = new int[9][9];
        model.addAttribute("board", board);
        return "sudoku";
    }

    @PostMapping("/solve")
    public String solveSudoku(@RequestParam Map<String, String> boardData, Model model) {
        int[][] board = new int[9][9];

        // Populate the board array from the map
        for (Map.Entry<String, String> entry : boardData.entrySet()) {
            if (entry.getKey().startsWith("board")) {
                String[] indices = entry.getKey().substring(6, entry.getKey().length() - 1).split("\\]\\[");
                int row = Integer.parseInt(indices[0]);
                int col = Integer.parseInt(indices[1]);
                board[row][col] = entry.getValue().isEmpty() ? 0 : Integer.parseInt(entry.getValue());
            }
        }

        boolean solved = solve(board);
        model.addAttribute("board", board);
        model.addAttribute("solved", solved);
        return "sudoku";
    }

    private boolean solve(int[][] board) {
        return solveSudoku(board, 0, 0);
    }

    private boolean solveSudoku(int[][] board, int row, int col) {
        if (row == 9) {
            return true; // Puzzle solved
        }

        if (col == 9) {
            return solveSudoku(board, row + 1, 0);
        }

        if (board[row][col] != 0) {
            return solveSudoku(board, row, col + 1);
        }

        for (int num = 1; num <= 9; num++) {
            if (isSafe(board, row, col, num)) {
                board[row][col] = num;

                if (solveSudoku(board, row, col + 1)) {
                    return true;
                }

                board[row][col] = 0; // Reset and backtrack
            }
        }

        return false; // Trigger backtracking
    }

    private boolean isSafe(int[][] board, int row, int col, int num) {
        // Check the row
        for (int x = 0; x < 9; x++) {
            if (board[row][x] == num) {
                return false;
            }
        }

        // Check the column
        for (int x = 0; x < 9; x++) {
            if (board[x][col] == num) {
                return false;
            }
        }

        // Check the 3x3 subgrid
        int startRow = row - row % 3;
        int startCol = col - col % 3;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (board[i + startRow][j + startCol] == num) {
                    return false;
                }
            }
        }

        return true;
    }
}


