import 'package:carbon_footprint_server/src/birthday_reminder.dart';
import 'package:carbon_footprint_server/src/future_calls/midnight_audit.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'package:carbon_footprint_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  // Configure Authentication
  // Configure Authentication with Gmail SMTP
  const gmailEmail = 'rachelcooraytest@gmail.com';
  const gmailPassword = 'vabm vqud ohek mubi'; // App Password

  final smtpServer = gmail(gmailEmail, gmailPassword);

  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      final message = Message()
        ..from = Address(gmailEmail, 'Carbon Butler')
        ..recipients.add(email)
        ..subject = 'Verify your Carbon Tracker Account'
        ..html = '''
          <h3>Welcome to Carbon Tracker! 🌿</h3>
          <p>Your verification code is:</p>
          <h1>$validationCode</h1>
          <p>Please enter this code in the app to activate your account.</p>
          <br>
          <p><i>- The Carbon Tracker Team</i></p>
        ''';

      // HACKATHON FIX: Print immediately and SKIP sending to avoid Render timeout
      print('-------------------------------------------');
      print('VALIDATION CODE: $validationCode');
      print('-------------------------------------------');

      // try {
      //   final sendReport = await send(message, smtpServer);
      //   print('Message sent: ${sendReport.toString()}');
      //   return true;
      // } catch (e) {
      //   print('Message not sent. \n${e.toString()}');
      //   return true; 
      // }
      return true; 
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      final email = userInfo.email;
      if (email == null) return false;

      final message = Message()
        ..from = Address(gmailEmail, 'Carbon Butler')
        ..recipients.add(email)
        ..subject = 'Reset your Password'
        ..html = '''
          <h3>Password Reset Request 🔐</h3>
          <p>Your password reset code is:</p>
          <h1>$validationCode</h1>
          <p>If you did not request this, please ignore this email.</p>
          <br>
          <p><i>- The Carbon Tracker Team</i></p>
        ''';

      // HACKATHON FIX: Print immediately and SKIP sending to avoid Render timeout
      print('-------------------------------------------');
      print('RESET CODE: $validationCode');
      print('-------------------------------------------');

      // try {
      //   final sendReport = await send(message, smtpServer);
      //   print('Reset message sent: ${sendReport.toString()}');
      //   return true;
      // } catch (e) {
      //   print('Reset message not sent. \n${e.toString()}');
      //   return true;
      // }
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
