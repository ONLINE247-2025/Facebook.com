<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facebook - Log in or Sign Up</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
        }

        body {
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #1c1e21;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            width: 100%;
            max-width: 400px;
            padding: 20px;
        }

        .logo {
            width: 240px;
            margin-bottom: 10px;
        }

        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1), 0 8px 16px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 100%;
            transition: all 0.3s ease;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #606770;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #dddfe2;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: #1877f2;
            box-shadow: 0 0 0 2px #e7f3ff;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border-radius: 6px;
            border: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-primary {
            background-color: #1877f2;
            color: white;
        }

        .btn-primary:hover {
            background-color: #166fe5;
        }

        .btn-secondary {
            background-color: #42b72a;
            color: white;
            margin-top: 10px;
        }

        .btn-secondary:hover {
            background-color: #36a420;
        }

        .divider {
            border-bottom: 1px solid #dadde1;
            margin: 20px 0;
        }

        .forgot-password {
            text-align: center;
            margin-top: 15px;
        }

        .forgot-password a {
            color: #1877f2;
            text-decoration: none;
            font-size: 14px;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        .otp-container {
            display: none;
        }

        .otp-inputs {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .otp-input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 20px;
            border: 1px solid #dddfe2;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .otp-input:focus {
            outline: none;
            border-color: #1877f2;
            box-shadow: 0 0 0 2px #e7f3ff;
        }

        .resend-otp {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .resend-otp a {
            color: #1877f2;
            text-decoration: none;
        }

        .resend-otp a:hover {
            text-decoration: underline;
        }

        .back-to-login {
            text-align: center;
            margin-top: 15px;
        }

        .back-to-login a {
            color: #1877f2;
            text-decoration: none;
            font-size: 14px;
        }

        .back-to-login a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #ff4d4f;
            font-size: 13px;
            margin-top: 5px;
            display: none;
        }

        .create-page {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .create-page a {
            color: #1c1e21;
            font-weight: 600;
            text-decoration: none;
        }

        .create-page a:hover {
            text-decoration: underline;
        }

        @media (max-width: 450px) {
            .card {
                box-shadow: none;
                background-color: transparent;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="https://static.xx.fbcdn.net/rsrc.php/y8/r/dF5SId3UHWd.svg" alt="Facebook" class="logo">
        
        <div class="card" id="loginCard">
            <h2 class="card-title">Log in to Facebook</h2>
            <form id="loginForm">
                <div class="form-group">
                    <input type="text" class="form-control" id="email" placeholder="Email or phone number" required>
                    <div class="error-message" id="emailError">Please enter a valid email or phone number</div>
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" id="password" placeholder="Password" required>
                    <div class="error-message" id="passwordError">Please enter your password</div>
                </div>
                <button type="submit" class="btn btn-primary">Log In</button>
                <div class="forgot-password">
                    <a href="#">Forgotten password?</a>
                </div>
                <div class="divider"></div>
                <button type="button" class="btn btn-secondary" id="createAccount">Create New Account</button>
            </form>
        </div>

        <div class="card otp-container" id="otpCard">
            <h2 class="card-title">Enter Security Code</h2>
            <p style="text-align: center; margin-bottom: 20px; font-size: 14px; color: #606770;">
                We've sent a 6-digit code to your email<br>
                <span id="userEmail" style="font-weight: 600;"></span>
            </p>
            <form id="otpForm">
                <div class="otp-inputs">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]">
                </div>
                <div class="error-message" id="otpError">Please enter the complete 6-digit code</div>
                <button type="submit" class="btn btn-primary">Continue</button>
                <div class="resend-otp">
                    Didn't receive a code? <a href="#" id="resendOtp">Resend</a>
                </div>
                <div class="back-to-login">
                    <a href="#" id="backToLogin">Back to login</a>
                </div>
            </form>
        </div>

        <div class="create-page">
            <a href="#">Meta © 2025</a>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginForm = document.getElementById('loginForm');
            const otpForm = document.getElementById('otpForm');
            const loginCard = document.getElementById('loginCard');
            const otpCard = document.getElementById('otpCard');
            const emailInput = document.getElementById('email');
            const passwordInput = document.getElementById('password');
            const emailError = document.getElementById('emailError');
            const passwordError = document.getElementById('passwordError');
            const otpError = document.getElementById('otpError');
            const userEmailSpan = document.getElementById('userEmail');
            const backToLogin = document.getElementById('backToLogin');
            const resendOtp = document.getElementById('resendOtp');
            const createAccount = document.getElementById('createAccount');
            const otpInputs = document.querySelectorAll('.otp-input');

            // Handle login form submission
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Reset error messages
                emailError.style.display = 'none';
                passwordError.style.display = 'none';
                
                let isValid = true;
                
                // Validate email/phone
                if (!emailInput.value.trim()) {
                    emailError.textContent = 'Please enter your email or phone number';
                    emailError.style.display = 'block';
                    isValid = false;
                } else if (!isValidEmailOrPhone(emailInput.value.trim())) {
                    emailError.textContent = 'Please enter a valid email or phone number';
                    emailError.style.display = 'block';
                    isValid = false;
                }
                
                // Validate password
                if (!passwordInput.value.trim()) {
                    passwordError.textContent = 'Please enter your password';
                    passwordError.style.display = 'block';
                    isValid = false;
                } else if (passwordInput.value.trim().length < 6) {
                    passwordError.textContent = 'Password must be at least 6 characters';
                    passwordError.style.display = 'block';
                    isValid = false;
                }
                
                if (isValid) {
                    // Simulate login process (in a real app, this would be an API call)
                    setTimeout(() => {
                        // Show OTP screen
                        userEmailSpan.textContent = emailInput.value.trim();
                        loginCard.style.display = 'none';
                        otpCard.style.display = 'block';
                        
                        // Focus first OTP input
                        otpInputs[0].focus();
                    }, 1000);
                }
            });

            // Handle OTP form submission
            otpForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                let otpComplete = true;
                let otpCode = '';
                
                otpInputs.forEach(input => {
                    if (!input.value.trim()) {
                        otpComplete = false;
                    }
                    otpCode += input.value.trim();
                });
                
                if (!otpComplete) {
                    otpError.style.display = 'block';
                    return;
                }
                
                otpError.style.display = 'none';
                
                // Simulate OTP verification (in a real app, this would be an API call)
                setTimeout(() => {
                    alert('Login successful! Welcome to Facebook.');
                    // Reset forms
                    loginForm.reset();
                    otpForm.reset();
                    // Show login screen again
                    loginCard.style.display = 'block';
                    otpCard.style.display = 'none';
                }, 1000);
            });

            // Handle OTP input navigation
            otpInputs.forEach((input, index) => {
                input.addEventListener('input', function() {
                    if (this.value.length === 1 && index < otpInputs.length - 1) {
                        otpInputs[index + 1].focus();
                    }
                });
                
                input.addEventListener('keydown', function(e) {
                    if (e.key === 'Backspace' && !this.value && index > 0) {
                        otpInputs[index - 1].focus();
                    }
                });
            });

            // Back to login link
            backToLogin.addEventListener('click', function(e) {
                e.preventDefault();
                loginCard.style.display = 'block';
                otpCard.style.display = 'none';
            });

            // Resend OTP link
            resendOtp.addEventListener('click', function(e) {
                e.preventDefault();
                alert('A new 6-digit code has been sent to your email.');
            });

            // Create account button
            createAccount.addEventListener('click', function() {
                alert('Redirecting to account creation page...');
            });

            // Helper function to validate email or phone
            function isValidEmailOrPhone(value) {
                // Simple email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                // Simple phone validation (just checking for digits)
                const phoneRegex = /^\d+$/;
                
                return emailRegex.test(value) || phoneRegex.test(value);
            }
        });
    </script>
</body>
</html>
