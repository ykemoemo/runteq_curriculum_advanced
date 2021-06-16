namespace :status_task do
  desc '公開待ちの中で1時間ごとに公開日時が過去のものになっていたらステータスを公開に変更する' 
  task update_status_task: :environment do
    Article.publish_wait.past_published.find_each(&:published!)
  end
end
