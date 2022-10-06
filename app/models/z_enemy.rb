class Enemy < Player
  def initialize(name)
    super(name)
    @attack_pattern = attack_patterns
    @current_targets = {}
  end

  def attack_patterns
    a = [%w[A0 B1 C2 D3 E4 F5 G6 H7 I8 J9 A4 B5 C6 D7 E8 F9 A8 B9 E0 F1 G2 H3 I4 J5 I0 J1],
         %w[A6 B7 C8 D9 A2 B3 C4 D5 E6 F7 G8 H9 C0 D1 E2 F3 G4 H5 I6 J7 G0 H1 I2 J3]]
    b = [%w[J0 I1 H2 G3 F4 E5 D6 C7 B8 A9 F0 E1 D2 C3 B4 A5 B0 A1 J4 I5 H6 G7 F8 E9 J8 I9],
         %w[D0 C1 B2 A3 H0 G1 F2 E3 D4 C5 B6 A7 J2 I3 H4 G5 F6 E7 D8 C9 J6 I7 H8 G9]]
    c = [%w[B0 C1 D2 E3 F4 G5 H6 I7 J8 A3 B4 C5 D6 E7 F8 G9 F0 G1 H2 I3 J4 A7 B8 C9 J0],
         %w[H0 I1 J2 D0 E1 F2 G3 H4 I5 J6 A1 B2 C3 D4 E5 F6 G7 H8 I9 A5 B6 C7 D8 E9 A9]]
    d = [%w[C0 D1 E2 F3 G4 H5 I6 J7 A2 B3 C4 D5 E6 F7 G8 H9 G0 H1 I2 J3 A6 B7 C8 D9 J0 A9],
         %w[I0 J1 A8 B9 E0 F1 G2 H3 I4 J5 A0 B1 C2 D3 E4 F5 G6 H7 I8 J9 A4 B5 C6 D7 E8 F9]]
    # e = D0 going right
    # f = I0 going left
    # g = H0 going left
    # h = H0 going left
    [a, b, c, d].sample
  end

  def target(opponent)
    return aimed_target opponent if @current_targets.length.positive?
    if @attack_pattern[0].length.positive?
      pos = @attack_pattern[0].delete_at(rand(@attack_pattern[0].length))
    else
      pos = @attack_pattern[1].delete_at(rand(@attack_pattern[1].length))
    end
    attack opponent, pos
  end

  def aimed_target(opponent)
    # once get_targets is done, this will work through those targets
    # but! if you attack at [x-1, y], then [x, y-1] and [x, y+1] should be removed... ugh
  end

  def attack(opponent, pos)
    super
    get_targets opponent, pos
  end

  def get_targets(opponent, pos)
    x, y = convert_pos(pos)
    if opponent.board.private_coords[y][x][0].health == 0
      @current_targets.delete(pos)
    else
      @current_targets[pos] = []
      # if opponent.board.private_coords [x+1, y], [x-1, y], [x,y+1] and [x, y-1] are equal to ' ', << them into @current_targets[pos]
    end
  end
end