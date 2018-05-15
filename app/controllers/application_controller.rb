require 'firebase_token_verifier'
require 'one_signal'

class ApplicationController < ActionController::API
  ANIMALS = ["AdorableAntEater", "BubblyBadger", "BraveBear", "BrilliantBull", "CuddlyCamel", "CharmingCat", "CleverChameleon", "CuddlyChicken", "CuriousCow", "ClassicCow", "CreativeCrocodile", "DelightfulDeer", "DearestDog", "DazzlingDolphin", "DarlingDonkey", "DiligentDuck", "ElectricElephant", "FabulousFish", "FlashyFox", "GraciousGiraffe", "GigglyGoat", "GorgeousGoose", "HumbleHedgehog", "HandsomeHippo", "HelpfulHorse", "KindKangaroo", "KeenKoala", "LuckyLion", "ModestMonkey", "MarvelousMoose", "MatureMouse", "ProductivePanda", "PopularPanther", "PerfectPenguin", "PlayfulPig", "RosyRabbit", "RadiantRaccoon", "ReliableRaven", "RealisticRhino", "SwiftSeal", "StrongSheep", "StrikingSnail", "ShimmeringSnake", "StylishSquirrel", "ThoughtfulTiger", "TruthfulTurtle", "UniqueUnicorn", "VibrantVulture", "WorldlyWolf", "ZestyZebra", "BelovedBear", "CheerfulCat", "DaringDog", "FunnyFish", "GloriousGiraffe", "PrettyPenguin", "PristinePig", "HandyHippo", "HappyHorse", "ZanyZebra"]
  FIREBASE_PROJECT_ID = 'animalparty-mobile'

  @@verifier = FirebaseTokenVerifier.new(FIREBASE_PROJECT_ID)

  def decode_token(firebase_jwt)
    decoded_firebase_jwt, error_msg = @@verifier.decode(firebase_jwt, nil)

    if error_msg
      return nil, error_msg
    end

    return decoded_firebase_jwt['user_id'], nil
  end

  def decode_token_and_find_user(firebase_jwt)
    decoded_firebase_jwt, error_msg = @@verifier.decode(firebase_jwt, nil)

    # Here we assume that either decoded_firebase_jwt or error_msg are nil
    # If there is an error_msg, we return immediately
    if error_msg
      return nil, error_msg
    end

    requester = User.find_by_firebase_uid(decoded_firebase_jwt['user_id'])

    if requester
      return requester, nil
    else
      return nil, 'Requester not found'
    end
  end

  # TODO: make this better for group messaging
  def create_notification(client_id, recipient_id, recipient_party, title, message, data)
    params = {
      app_id: ENV["ANIMALPARTY_ONE_SIGNAL_APP_ID"],
      contents: { en: message },
      ios_badgeType: 'Increase',
      ios_badgeCount: 1,
      android_led_color: '007aff',
      android_accent_color: recipient_party == 'DEMOCRAT' ? '007aff' : 'ff313a',
      filters: [{"field": "tag", "key": "user_id", "relation": "=", "value": recipient_id.to_s}],
      data: data,
      headings: title,
      android_group: client_id
    }

    begin
      response = OneSignal::Notification.create(params: params, opts: { auth_key: ENV["ANIMALPARTY_ONE_SIGNAL_AUTH_KEY"] })
      notification_id = JSON.parse(response.body)["id"]
    rescue OneSignal::OneSignalError => e
      puts "--- OneSignalError  :"
      puts "-- message : #{e.message}"
      puts "-- status : #{e.http_status}"
      puts "-- body : #{e.http_body}"
    end
  end

  def get_message_notification_preview(message)
    if message.body
      message_preview = message.body
    else
      message_preview = 'Sent you an image.'
    end

    return message_preview
  end

  def get_username(user)
    return ANIMALS[user.created_at.sec] + user.id.to_s;
  end

end
