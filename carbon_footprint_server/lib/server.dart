import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:carbon_footprint_server/src/birthday_reminder.dart';
import 'package:carbon_footprint_server/src/future_calls/midnight_audit.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'package:carbon_footprint_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

Future<bool> _sendEmailViaSendGrid(Session session, String to, String subject, String htmlContent) async {
  // Robust API key loading (Checks multiple casings and direct System Environment)
  final apiKey = session.serverpod.getPassword('sendgrid_api_key') 
              ?? session.serverpod.getPassword('SENDGRID_API_KEY')
              ?? Platform.environment['SERVERPOD_PASSWORD_SENDGRID_API_KEY']
              ?? Platform.environment['SENDGRID_API_KEY'];

  final fromEmail = session.serverpod.getPassword('sendgrid_sender_email') 
                 ?? session.serverpod.getPassword('SENDGRID_SENDER_EMAIL')
                 ?? Platform.environment['SERVERPOD_PASSWORD_SENDGRID_SENDER_EMAIL']
                 ?? Platform.environment['SENDGRID_SENDER_EMAIL']
                 ?? 'rachelcooraytest@gmail.com'; 

  if (apiKey == null) {
    print('ERROR: SENDGRID_API_KEY not found in passwords.yaml or ENV. Cannot send email.');
    return false;
  }

  final url = Uri.parse('https://api.sendgrid.com/v3/mail/send');
  
  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'personalizations': [
          {
            'to': [{'email': to}]
          }
        ],
        'from': {'email': fromEmail, 'name': 'Carbon Butler'},
        'subject': subject,
        'content': [
          {'type': 'text/html', 'value': htmlContent}
        ]
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('SendGrid: Email sent successfully to $to');
      return true;
    } else {
      print('SendGrid: Failed to send email. Status: ${response.statusCode}, Body: ${response.body}');
      return false;
    }
  } catch (e) {
    print('SendGrid: Exception while sending email: $e');
    return false;
  }
}

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      final html = '''
          <h3>Welcome to Carbon Tracker! 🌿</h3>
          <p>Your verification code is:</p>
          <h1>$validationCode</h1>
          <p>Please enter this code in the app to activate your account.</p>
          <br>
          <p><i>- The Carbon Tracker Team</i></p>
        ''';

      // Still print for the logs as a double safety
      print('-------------------------------------------');
      print('SENDER: SendGrid API');
      print('VALIDATION CODE: $validationCode');
      print('-------------------------------------------');

      await _sendEmailViaSendGrid(session, email, 'Verify your Carbon Tracker Account', html);
      return true; // Always return true for hackathon to allow flow to continue
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      final email = userInfo.email;
      if (email == null) return false;

      final html = '''
          <h3>Password Reset Request 🔐</h3>
          <p>Your password reset code is:</p>
          <h1>$validationCode</h1>
          <p>If you did not request this, please ignore this email.</p>
          <br>
          <p><i>- The Carbon Tracker Team</i></p>
        ''';

      print('-------------------------------------------');
      print('SENDER: SendGrid API');
      print('RESET CODE: $validationCode');
      print('-------------------------------------------');

      await _sendEmailViaSendGrid(session, email, 'Reset your Password', html);
      return true;
    },
  ));

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // Start the server.
  await pod.start();

  // After starting the server, you can register future calls. Future calls are
  // tasks that need to happen in the future, or independently of the request/response
  // cycle. For example, you can use future calls to send emails, or to schedule
  // tasks to be executed at a later time. Future calls are executed in the
  // background. Their schedule is persisted to the database, so you will not
  // lose them if the server is restarted.

  pod.registerFutureCall(
    BirthdayReminder(),
    FutureCallNames.birthdayReminder.name,
  );

  pod.registerFutureCall(
    MidnightAudit(),
    FutureCallNames.midnightAudit.name,
  );

  // You can schedule future calls for a later time during startup. But you can also
  // schedule them in any endpoint or webroute through the session object.
  // there is also [futureCallAtTime] if you want to schedule a future call at a
  // specific time.
  await pod.futureCallWithDelay(
    FutureCallNames.birthdayReminder.name,
    Greeting(
      message: 'Hello!',
      author: 'Serverpod Server',
      timestamp: DateTime.now(),
    ),
    Duration(seconds: 5),
  );

  // Schedule first Midnight Audit in 1 minute for demonstration/verification
  await pod.futureCallWithDelay(
    FutureCallNames.midnightAudit.name,
    null,
    const Duration(minutes: 1),
  );
}

/// Names of all future calls in the server.
///
/// This is better than using a string literal, as it will reduce the risk of
/// typos and make it easier to refactor the code.
enum FutureCallNames {
  birthdayReminder,
  midnightAudit,
}
