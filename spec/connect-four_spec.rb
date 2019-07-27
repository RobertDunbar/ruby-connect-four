require "./player.rb"
require "./game.rb"
require "./board.rb"

RSpec.describe Player do
    player = Player.new("rob", :blue)

    describe "#intialize" do
        it "name is correct" do
            expect(player.name).to eql("rob")
        end
        it "colour is correct" do
            expect(player.colour).to eql(:blue)
        end
    end
end

RSpec.describe Board do
    board = Board.new

    describe "#intialize" do
        it "there are 42 cells unfilled" do
            expect(board.cells).to eql(Array.new(6, Array.new(7, 0)))
        end
    end

    describe "#new_moves_array" do
        it "check correct board positions are generated" do
            expect(board.new_moves_array(3,3)).to eql(
                [[[5,3],[4,3],[3,3],[2,3],[1,3],[0,3]],
                [[3,0],[3,1],[3,2],[3,3],[3,4],[3,5],[3,6]],
                [[5,1],[4,2],[3,3],[2,4],[1,5],[0,6]],
                [[0,0],[1,1],[2,2],[3,3],[4,4],[5,5]]])
        end
    end

    describe "#check_win_lines" do
        it "check non-winning lines are indentified" do
            [[5,3],[4,3],[2,3],[1,3]].each do |pos|
                board.cells[pos[0]][pos[1]] = "X"
            end
            expect(board.check_win_lines(3,3)).to eql(false)
        end
        it "check winning lines are indentified" do
            [[5,3],[4,3],[3,3],[2,3],[1,3],[0,3]].each do |pos|
                board.cells[pos[0]][pos[1]] = "Y"
            end
            [[5,3],[4,3],[3,3],[2,3]].each do |pos|
                board.cells[pos[0]][pos[1]] = "X"
            end
            expect(board.check_win_lines(3,3)).to eql("winner")
        end
    end
end

RSpec.describe Game do
    game = Game.new

    describe "#intialize" do
        it "objects are created correctly" do
            expect(game.player1).to be_a Player
            expect(game.player2).to be_a Player
            expect(game.board).to be_a Board
        end
    end

    describe "#player_switch" do
        it "check players are switched" do
            expect(game.player_switch(game.player1)).to eql(game.player2)
            expect(game.player_switch(game.player2)).to eql(game.player1)
        end
    end

    describe "#end_of_game?" do
        it "check it knows when the board is full - no winner" do
            game.board.columns_full = [1,2,3,4,5,6,7]
            expect(game.end_of_game?(3,4)).to eql("full")
        end
    end

    describe "#check_valid_num" do
        it "checks for valid board numerical input position false" do
            expect(game.check_valid_num?("f")).to eql(nil)
        end
        it "checks for valid board numerical input position true" do
            expect(game.check_valid_num?("5")).to be_truthy
        end
    end
end