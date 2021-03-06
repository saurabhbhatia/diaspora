class Notifier < ActionMailer::Base
  helper :application
  helper :markdownify
  helper :notifier
  
  def self.admin(string, recipients, opts = {})
    mails = []
    recipients.each do |rec|
      mail = single_admin(string, rec)
      mails << mail
    end
    mails
  end

  def single_admin(string, recipient)
    @receiver = recipient
    @string = string.html_safe
    mail(:to => @receiver.email,
         :subject => I18n.t('notifier.single_admin.subject'), :host => AppConfig[:pod_uri].host)
  end

  def started_sharing(recipient_id, sender_id)
    send_notification(:started_sharing, recipient_id, sender_id)
  end

  def liked(recipient_id, sender_id, like_id)
    send_notification(:liked, recipient_id, sender_id, like_id)
  end

  def reshared(recipient_id, sender_id, reshare_id)
    send_notification(:reshared, recipient_id, sender_id, reshare_id)
  end

  def mentioned(recipient_id, sender_id, target_id)
    send_notification(:mentioned, recipient_id, sender_id, target_id)
  end

  def comment_on_post(recipient_id, sender_id, comment_id)
    send_notification(:comment_on_post, recipient_id, sender_id, comment_id)
  end

  def also_commented(recipient_id, sender_id, comment_id)
    send_notification(:also_commented, recipient_id, sender_id, comment_id)
  end

  def private_message(recipient_id, sender_id, message_id)
    send_notification(:private_message, recipient_id, sender_id, message_id)
  end

  def confirm_email(recipient_id)
    send_notification(:confirm_email, recipient_id)
  end

  private
  def send_notification(type, *args)
    @notification = NotificationMailers.const_get(type.to_s.camelize).new(*args)

    with_recipient_locale do
      mail(@notification.headers)
    end
  end

  def with_recipient_locale(&block)
    I18n.with_locale(@notification.recipient.language, &block)
  end
end