task :cat_item_synchronizer => :environment do
  CatItemSynchronizer::Scheduler.run
end