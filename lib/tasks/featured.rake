task :featured, [:three_talks] => [:environment] do |task, args|
  three_talks = args[:three_talks]
  three_talks = three_talks.split('|||')
  puts three_talks
  res = []
  three_talks.each do |slug|
    talk = Workshop.find_by(slug: slug)
    if talk
      puts "Talk ID for #{slug} is #{talk.id}"
      res << talk
    else
      puts "Can't find Talk ID with slug #{slug}"
    end
  end

  if res.length == 3
    Workshop.where(featured: true).update_all(featured: false)
    res.each {|w| w.update(featured: true)}
    puts "Done setting these 3 talks as featured"
  else
    puts "You need to pass 3 correct talk slugs in order for to set 3 featured talks"
  end
end