def fixing_rubocop
  after_bundle do
    use_source_path __dir__

    cops = %w(
      Style/FrozenStringLiteralComment 
      Layout/EmptyLineAfterMagicComment
    ).join(',')
  
    run "rubocop --only #{cops} --auto-correct-all"
  end
end

fixing_rubocop
