# frozen_string_literal: true

def fixing_rubocop
  after_bundle do
    use_source_path __dir__

    cops = %w[
      Style/FrozenStringLiteralComment
      Style/StringLiterals
      Layout/EmptyLineAfterMagicComment
    ].join(',')

    run "rubocop --only #{cops} --auto-correct-all --out tmp/template_rubocop.txt"
  end
end

fixing_rubocop
