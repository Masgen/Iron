module SubscriptionsHelper
  def new_subscription_helper(subscription)
    if subscription.created_at.between?(1.week.ago, 0.seconds.ago)
      content_tag :td, subscription.email, class: "new"
    else
      content_tag :td, subscription.email
    end
  end
end
