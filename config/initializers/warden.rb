# gets user from cookie info
Warden::Manager.after_set_user do |user, auth, opts| 
  scope = opts[:scope] 
  auth.cookies.signed["#{scope}.id"] = user.id
end

# destroys cookie info
Warden::Manager.before_logout do |user, auth, opts| 
  scope = opts[:scope] 
  auth.cookies.signed["#{scope}.id"] = nil
end
