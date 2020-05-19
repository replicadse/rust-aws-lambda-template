#[macro_use]
extern crate lambda_runtime as lambda;
#[macro_use]
extern crate serde_derive;
#[macro_use]
extern crate log;
extern crate simple_logger;

use std::error::Error;
use lambda::error::HandlerError;

#[derive(Debug, Deserialize, Clone)]
#[serde(rename_all = "snake_case")]
struct CustomEvent {
    the_name: String,
}

#[derive(Debug, Serialize, Clone)]
struct CustomOutput {
    message: String,
}

fn main() -> Result<(), Box<dyn Error>> {
    simple_logger::init_with_level(log::Level::Info)?;
    lambda!(handler);
    Ok(())
}

fn handler(e: serde_json::Value, c: lambda::Context) -> Result<CustomOutput, HandlerError> {
    match std::panic::catch_unwind(|| {
        let event: CustomEvent = serde_json::from_value(e).unwrap();
        info!("{:?}", event);

        if event.the_name == "" {
            error!("Empty first name in request {}", c.aws_request_id);
            return Err(c.new_error("Empty first name"));
        }
        Ok(CustomOutput {
            message: format!("Hello, {}!", event.the_name),
        })
    }) {
        Ok(x) => x,
        Err(_) => Err(c.new_error("panic")),
    }
}
