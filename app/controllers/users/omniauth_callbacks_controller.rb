# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # Facebook上でメール使用を許可しているかの分岐
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
          uid: data['uid']
        }
      end
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  # def twitter
  #   user = User.from_omniauth(request.env['omniauth.auth'])
  #   if user
  #     sign_in_and_redirect user, event: :authentication
  #     set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
  #   else
  #     if (data = request.env['omniauth.auth'])
  #       session['devise.omniauth_data'] = {
  #         email: data['info']['email'],
  #         provider: data['provider'],
  #         uid: data['uid']
  #       }
  #     end
  #     redirect_to new_user_registration_url
  #   end
  # end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
