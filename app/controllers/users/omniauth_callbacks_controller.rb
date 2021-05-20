# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    redirect_to '/users/auth/facebook?auth_type=rerequest&scope=email' if request.env['omniauth.auth'].info.email.blank?

    # User.from_omniauthはModel側で実装
    user = User.from_omniauth(request.env['omniauth.auth'])

    # すでにuserが登録済みかの判定
    if user
      # 登録済みならログイン
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      # 新規登録用にセッションに必要情報を格納
      if (data = request.env['omniauth.auth'])
        session['devise.omniauth_data'] = {
          email: data['info']['email'],
          provider: data['provider'],
          uid: data['uid'],
          username: data['info']['name']
        }
      end
      redirect_to new_user_registration_url
    end
  end
  

  def failure
    redirect_to root_path
  end

  def twitter
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      if (data = request.env['omniauth.auth'])
        session['devise.omniauth_data'] = {
            email: data['info']['email'],
            provider: data['provider'],
            uid: data['uid']
        }
      end
      redirect_to new_user_registration_url
    end
  end
end
