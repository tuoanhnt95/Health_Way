console.log("demo_login")

const demoLoginEmail = "oanh_nguyen@healthway.live"
const demoLoginPassword = "123123"

const email = document.querySelector('#user_email')
const password = document.querySelector('#user_password')
const demo = document.querySelector('#demo-login')
const form = document.querySelector('#new_user')

demo.addEventListener('click', (e) => {
    e.preventDefault()
    email.value = demoLoginEmail
    password.value = demoLoginPassword
    form.submit()
})
