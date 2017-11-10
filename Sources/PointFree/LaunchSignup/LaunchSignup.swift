import Either
import Foundation
import Html
import HttpPipeline
import HttpPipelineHtmlSupport
import Prelude

let homeResponse =
  analytics
    >-> writeStatus(.ok)
    >-> respond(launchSignupView)

let signupResponse =
  analytics
    >-> airtableStuff
    >-> redirect(to: path(to: .home(signedUpSuccessfully: true)))

private func airtableStuff<I>(_ conn: Conn<I, Never, String>) -> IO<Conn<I, Never, Either<Prelude.Unit, Prelude.Unit>>> {

  let result = [EnvVars.Airtable.base1, EnvVars.Airtable.base2, EnvVars.Airtable.base3]
    .map(AppEnvironment.current.airtableStuff(conn.data.right!))
    .reduce(lift(.left(unit))) { $0 <|> $1 }
    .run

  return result.map { conn.map(const($0)) }
}

private func analytics<I, A>(_ conn: Conn<I, Never, A>) -> IO<Conn<I, Never, A>> {
  return IO {
    print("tracked analytics")
    return conn
  }
}
