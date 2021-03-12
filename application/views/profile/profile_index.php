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
	if (!$this->userauth->is_level(ADMINISTRATOR)) {
?>
		<!-- Nah yang disini harusnya ada suatu if kalau hari login yg sekarang tu masih masuk dalam satu minggu ini, jadi yg ditampilin jadwalnya tuh masih jadwal di minggu ini, bukan di minggu2 lainnya. -->

		<!-- Trus yg ditampilin dibawah tu diambil data dalam kurun satu minggu ini -->

		<!-- Ngambil data Matkul -->
		<!-- $output1 = html_escape(strlen($this->booking->notes) > 1 ? $this->userauth->booking->notes : $this->userauth->booking->notes); -->
		<!-- Ngambil data Sesi -->
		<!-- $output2 = html_escape(strlen($this->userauth->period->name) > 1 ? $this->userauth->period->name : $this->userauth->period->name); -->
		<!-- Ngambil data Ruangan -->
		<!-- $output3 = html_escape(strlen($this->userauth->room->name) > 1 ? $this->userauth->room->name : $this->userauth->room->name); -->

		<h3 align:'center'>My Courses In A Week</h3>
		<table border='1' width='20%' cellspacing='0' cellpadding='0' id='table2'>
			<tr>
				<td align='center'>Day</td>
				<td align='center'>Course</td>
				<td align='center'>Sesi</td>
				<td align='center'>Room</td>
			</tr>
			<?php foreach ($jadwal as $row) :
				$output1 = date("l", strtotime($row->date));
				$output2 = $row->notes;
				$output3 = $row->sesi;
				$output4 = $row->ruang;
				// Ini ada if kalau misal si dosen gaada jadwal, maka tabel matkul/sesi/ruangannya diisi -
				if ($output1 == "") {
					$output1 = "-";
				} else {
					$output1 = $output1;
				}
				if ($output2 == "") {
					$output2 = "-";
				} else {
					$output2 = $output2;
				}
				if ($output3 == "") {
					$output3 = "-";
				} else {
					$output3 = $output3;
				}
				if ($output4 == "") {
					$output4 = "-";
				} else {
					$output4 = $output4;
				}
			?>
				<!-- Mulai bikin tabelnya -->
				<tr>
					<td align='center'><?= $output1 ?></td>
					<td align='center'><?= $output2 ?></td>
					<td align='center'><?= $output3 ?></td>
					<td align='center'><?= $output4 ?></td>
				</tr>
			<?php endforeach; ?>

		</table>
<?php }
}
?>

<?php foreach($users as $us) { ?>
<h3>My details</h3>
<p>Nama: <?= $us->firstname. " " .$us->lastname; ?></p>
<p>Email: <?= $us->email; ?></p>
<p>Foto:  </p>
<img src="<?= base_url('foto/') . $us->foto; ?>" width="120px" style="margin-left: 50px;">
<?php } ?>

<h3>My total bookings</h3>
<ul>
	<li>Number of bookings ever made: <?php echo $total['all'] ?></li>
	<li>Number of bookings this year to date: <?php echo $total['yeartodate'] ?></li>
	<li>Number of current active bookings: <?php echo $total['active'] ?></li>
</ul>