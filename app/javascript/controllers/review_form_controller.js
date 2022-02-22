import { Controller } from "@hotwired/stimulus";
import $ from "jquery";
import "jquery-bar-rating"

   // import 'select2/dist/css/select2.min.css'; <- Uncomment this line if you are using Rails

   export default class extends Controller {
     connect(){
       $(function() {
      $('#review_rating').barrating({
        theme: 'css-stars',
        showSelectedRating: false
    });
    });
     }

   }
