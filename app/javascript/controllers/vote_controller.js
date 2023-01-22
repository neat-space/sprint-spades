import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  vote(event) {
    // Get the value of the button that was clicked
    const voteValue = event.target.innerHTML;
    // Perform some action with the vote value, such as sending it to the server via an AJAX call
    console.log(`Voted for ${voteValue}`);
  }
}