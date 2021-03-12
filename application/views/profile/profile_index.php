<?php
echo $this->session->flashdata('saved');

echo iconbar(array(
	array('profile/edit', 'Edit my details', 'user_edit.png'),
));

?>

<?php if ($myroom) { ?>
	<h3>Staff bookings in my rooms</h3>
	<ul>
		<?php
		foreach ($myroom as $booking) {
			$string = '<li>%s is booked on %s by %s for %s. %s</li>';
			if ($booking->notes) {
				$booking->notes = '(' . $booking->notes . ')';
			}
			if (!$booking->displayname) {
				$booking->displayname = $booking->username;
			}
			echo sprintf($string, html_escape($booking->name), date("d/m/Y", strtotime($booking->date)), html_escape($booking->displayname), html_escape($booking->periodname), html_escape($booking->notes));
		}
		?>
	</ul>
<?php } ?>



<?php if ($mybookings) { ?>
	<h3>My bookings</h3>
	<ul>
		<?php
		foreach ($mybookings as $booking) {
			$string = '<li>%s is booked on %s for %s. %s.</li>';
			$notes = '';
			if ($booking->notes) {
				$notes = '(' . $booking->notes . ')';
			}
			echo sprintf($string, html_escape($booking->name), date("d/m/Y", strtotime($booking->date)), html_escape($booking->periodname), html_escape($notes));
		}
		?>
	</ul>
<?php } ?>

<?php
//userauth->logged_in ngambil data siapa user yg login sekarang
if ($this->userauth->logged_in()) {
	// Nah yang disini harusnya ada suatu if kalau hari login yg sekarang tu masih masuk dalam satu minggu ini, jadi yg ditampilin jadwalnya tuh masih jadwal di minggu ini, bukan di minggu2 lainnya.

	// Trus yg ditampilin dibawah tu diambil data dalam kurun satu minggu ini

	// Ngambil data Matkul
	$output = html_escape(strlen($this->userauth->booking->notes) > 1 ? $this->userauth->booking->notes : $this->userauth->booking->notes);
	// Ngambil data Sesi
	$output2 = html_escape(strlen($this->userauth->period->name) > 1 ? $this->userauth->period->name : $this->userauth->period->name);
	// Ngambil data Ruangan
	$output3 = html_escape(strlen($this->userauth->room->name) > 1 ? $this->userauth->room->name : $this->userauth->room->name);
	echo "<h3 align:'center'>Jadwal Minggu Ini</h3>";
	// Ini ada if kalau misal si dosen gaada jadwal, maka tabel matkul/sesi/ruangannya diisi -
	if ($this->userauth->booking->notes == "") {
		$output = "-";
	} else {
		$output = $output;
	}
	if ($this->userauth->booking->notes == "") {
		$output2 = "-";
	} else {
		$output2 = $output2;
	}
	if ($this->userauth->booking->notes == "") {
		$output3 = "-";
	} else {
		$output3 = $output3;
	}
	// Mulai bikin tabelnya
	echo "<table border='1' width='20%' cellspacing='0' cellpadding='0' id='table2'>";
	echo "<tr><td align='center'>Mata Kuliah</td><td align='center'>Sesi</td><td align='center'>Ruang</td></tr>";
	echo "<tr><td align='center'>{$output}</td><td align='center'>{$output2}</td><td align='center'>{$output3}</td></tr>";
	echo "</table>";
}
?>

<h3>My total bookings</h3>
<ul>
	<li>Number of bookings ever made: <?php echo $total['all'] ?></li>
	<li>Number of bookings this year to date: <?php echo $total['yeartodate'] ?></li>
	<li>Number of current active bookings: <?php echo $total['active'] ?></li>
</ul>